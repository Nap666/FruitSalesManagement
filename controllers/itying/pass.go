package itying

import (
	"beegoxiaomi/models"
	"fmt"
	"regexp"
	"strings"

	beego "github.com/beego/beego/v2/server/web"
)

type PassController struct {
	beego.Controller
}

func (c *PassController) Login() {
	c.Data["prevPage"] = c.Ctx.Request.Referer()
	c.TplName = "itying/pass/login.html"
}

func (c *PassController) DoLogin() {

	phone := c.GetString("phone")
	password := c.GetString("password")
	photo_code := c.GetString("photo_code")
	photoCodeId := c.GetString("photoCodeId")

	// 1、验证图形验证码是否正确
	identifyFlag := models.Cpt.Verify(photoCodeId, photo_code)
	if !identifyFlag {
		c.Data["json"] = map[string]interface{}{
			"success": false,
			"msg":     "输入的图形验证码不正确",
		}
		c.ServeJSON()
		return
	}

	// 2、验证用户信息是否正确
	password = models.Md5(password)
	user := []models.User{}
	models.DB.Where("phone=? AND password=?", phone, password).Find(&user)
	if len(user) > 0 { //登录成功

		// 把用户信息保存在cookie里面
		models.Cookie.Set(c.Ctx, "userinfo", user[0])
		c.Data["json"] = map[string]interface{}{
			"success": true,
			"msg":     "登录成功",
		}
		c.ServeJSON()
		return

	}

	c.Data["json"] = map[string]interface{}{
		"success": false,
		"msg":     "用户名或者密码错误",
	}
	c.ServeJSON()
	return

}

func (c *PassController) RegisterStep1() {
	fmt.Println(models.GetRandomNum())
	c.TplName = "itying/pass/register_step1.html"
}

func (c *PassController) RegisterStep2() {

	var sign = c.GetString("sign")
	var photo_code = c.GetString("photo_code")

	//1、图形验证码是否正确
	sessionPhotoCode := c.GetSession("photo_code")
	if photo_code != sessionPhotoCode {
		c.Redirect("/pass/registerStep1", 302)
		return
	}
	//2、签名是否正确
	userTemp := []models.UserTemp{}
	models.DB.Where("sign=?", sign).Find(&userTemp)
	if len(userTemp) > 0 {
		c.Data["sign"] = sign
		c.Data["photo_code"] = photo_code
		c.Data["phone"] = userTemp[0].Phone
		c.TplName = "itying/pass/register_step2.html"
	} else {
		c.Redirect("/pass/registerStep1", 302)
		return
	}

}
func (c *PassController) RegisterStep3() {

	var sign = c.GetString("sign")
	var sms_code = c.GetString("sms_code")

	//1、验证短信验证码是否正确
	sessionSmsCode := c.GetSession("sms_code")
	if sms_code != sessionSmsCode {
		c.Redirect("/pass/registerStep1", 302)
		return
	}
	//2、签名是否正确
	userTemp := []models.UserTemp{}
	models.DB.Where("sign=?", sign).Find(&userTemp)
	if len(userTemp) > 0 {
		c.Data["sign"] = sign
		c.Data["sms_code"] = sms_code
		c.TplName = "itying/pass/register_step3.html"
	} else {
		c.Redirect("/pass/registerStep1", 302)
		return
	}

}

// 执行注册
func (c *PassController) DoRegister() {

	sign := c.GetString("sign")
	sms_code := c.GetString("sms_code")
	password := c.GetString("password")
	rpassword := c.GetString("rpassword")
	//1、验证短信验证码是否正确
	sessionSmsCode := c.GetSession("sms_code")
	if sms_code != sessionSmsCode {
		c.Redirect("/pass/registerStep1", 302)
		return
	}
	//2、密码是否合法  (正则)
	if len(password) > 6 {
		c.Redirect("/pass/registerStep1", 302)
	}
	if password != rpassword {
		c.Redirect("/pass/registerStep1", 302)
	}
	//3、验证签名是否正确
	userTemp := []models.UserTemp{}
	models.DB.Where("sign=?", sign).Find(&userTemp)
	ip := strings.Split(c.Ctx.Request.RemoteAddr, ":")[0] //获取客户端ip
	fmt.Printf("******************************注册时ip:", ip)
	if len(userTemp) > 0 {
		//完成注册
		user := models.User{
			Phone:    userTemp[0].Phone,
			Password: models.Md5(password), //密码要加密
			LastIp:   ip,
		}
		models.DB.Create(&user)

		//保存用户信息 登录
		models.Cookie.Set(c.Ctx, "userinfo", user)
		c.Redirect("/", 302)

	} else {
		c.Redirect("/pass/registerStep1", 302)
	}
}

// 发送验证码
func (c *PassController) SendCode() {

	phone := c.GetString("phone")
	photo_code := c.GetString("photo_code")
	photoCodeId := c.GetString("photoCodeId")
	if photoCodeId == "resend" { //重新发送验证码需要用到
		//session里面验证验证码是否合法
		sessionPhotoCode := c.GetSession("photo_code")
		if sessionPhotoCode != photo_code {
			c.Data["json"] = map[string]interface{}{
				"success": false,
				"msg":     "输入的图形验证码不正确，非法请求",
			}
			c.ServeJSON()
			return
		}
	} else {
		//1、验证图形验证码是否正确
		if !models.Cpt.Verify(photoCodeId, photo_code) {
			c.Data["json"] = map[string]interface{}{
				"success": false,
				"msg":     "输入的图形验证码不正确",
			}
			c.ServeJSON()
			return
		}

		c.SetSession("photo_code", photo_code)
	}

	/*
		2、判断手机格式是否合法
				pattern := `^[\d]{11}$`
				reg := regexp.MustCompile(pattern)
				reg.MatchString(phone)
	*/

	pattern := `^[\d]{11}$`
	reg := regexp.MustCompile(pattern)
	if !reg.MatchString(phone) {
		c.Data["json"] = map[string]interface{}{
			"success": false,
			"msg":     "手机号的格式不正确",
		}
		c.ServeJSON()
		return
	}

	//3、验证手机号是否注册过
	user := []models.User{}
	models.DB.Where("phone=?", phone).Find(&user)
	if len(user) > 0 {
		c.Data["json"] = map[string]interface{}{
			"success": false,
			"msg":     "此用户已经存在",
		}
		c.ServeJSON()
		return
	}

	//4、验证手机注册的次数

	add_day := models.GetDay()                            //年月日
	ip := strings.Split(c.Ctx.Request.RemoteAddr, ":")[0] //ip 127.0.0.1:64912
	sign := models.Md5(phone + add_day)                   //签名
	sms_code := models.GetRandomNum()                     //发送短信的随机码

	userTemp := []models.UserTemp{}
	models.DB.Where("add_day=? AND phone=?", add_day, phone).Find(&userTemp)

	var sendCount int
	models.DB.Where("add_day=? AND ip=?", add_day, ip).Table("user_temp").Count(&sendCount)

	//当前ip地址今天发送的次数
	if sendCount <= 10 {
		if len(userTemp) > 0 {
			//验证当前手机号今天发送的次数是否合法
			if userTemp[0].SendCount < 5 {
				//1、发送验证码
				models.SendMsg(sms_code)
				//2、保存验证码
				c.SetSession("sms_code", sms_code)
				//3、更新发送短信信息
				oneUserTemp := models.UserTemp{}
				models.DB.Where("id=?", userTemp[0].Id).Find(&oneUserTemp)
				oneUserTemp.SendCount = oneUserTemp.SendCount + 1
				models.DB.Save(&oneUserTemp)

				c.Data["json"] = map[string]interface{}{
					"success": true,
					"msg":     "短信发送成功",
					"sign":    sign,
					// "sms_code": sms_code, //测试期间返回数据
				}
				c.ServeJSON()
				return

			} else {
				c.Data["json"] = map[string]interface{}{
					"success": false,
					"msg":     "当前手机号今天发送短信的次数太多了，明天再试",
				}
				c.ServeJSON()
				return
			}

		} else {
			//1、发送验证码
			models.SendMsg(sms_code)
			//2、保存验证码
			c.SetSession("sms_code", sms_code)
			//3、保存发送的信息
			oneUserTemp := models.UserTemp{
				Ip:        ip,
				Phone:     phone,
				SendCount: 1,
				AddDay:    add_day,
				AddTime:   int(models.GetUnix()),
				Sign:      sign,
			}
			models.DB.Create(&oneUserTemp)

			c.Data["json"] = map[string]interface{}{
				"success": true,
				"msg":     "短信发送成功",
				"sign":    sign,
				// "sms_code": sms_code, //测试期间返回数据
			}
			c.ServeJSON()
			return

		}
	} else {
		c.Data["json"] = map[string]interface{}{
			"success": false,
			"msg":     "此ip今天发送次数已经达到上限，明天再试",
		}
		c.ServeJSON()
		return

	}

}

// 验证验证码
func (c *PassController) ValidateSmsCode() {
	sign := c.GetString("sign")
	//获取用户输入的的短信验证码
	sms_code := c.GetString("sms_code")
	//1、验证数据是否合法
	userTemp := []models.UserTemp{}
	models.DB.Where("sign=?", sign).Find(&userTemp)
	if len(userTemp) == 0 {
		c.Data["json"] = map[string]interface{}{
			"success": false,
			"msg":     "参数错误",
		}
		c.ServeJSON()
		return
	}

	//2、验证短信验证码是否正确
	//可以从云片服务器拿取，但是没去租服务器，验证码随机数生辰在code.txt
	sessionSmsCode := c.GetSession("sms_code")
	if sessionSmsCode != sms_code {
		c.Data["json"] = map[string]interface{}{
			"success": false,
			"msg":     "输入的短信验证码错误",
		}
		c.ServeJSON()
		return
	}
	//3、判断验证码有没有过期   15分
	nowTime := models.GetUnix()
	if (nowTime-int64(userTemp[0].AddTime))/1000/60 > 15 {
		c.Data["json"] = map[string]interface{}{
			"success": false,
			"msg":     "验证码已经过期",
		}
		c.ServeJSON()
		return
	}

	c.Data["json"] = map[string]interface{}{
		"success": true,
		"msg":     "验证码输入正确",
	}
	c.ServeJSON()
}

// 退出登录
func (c *PassController) LoginOut() {
	models.Cookie.Remove(c.Ctx, "userinfo", "")
	c.Redirect("/", 302)
}
