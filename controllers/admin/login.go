package admin

import (
	"beegoxiaomi/models"
	"strings"
)

type LoginController struct {
	BaseController
}

func (c *LoginController) Get() {
	//获取user表的数据验证数据库是否连接成功

	c.TplName = "admin/login/login.html"
}

func (c *LoginController) DoLogin() {

	//1、验证用户输入的验证码是否正确
	var flag = models.Cpt.VerifyReq(c.Ctx.Request)
	if flag {
		//2、获取表单传过来的用户名和密码
		username := strings.Trim(c.GetString("username"), " ")
		password := models.Md5(strings.Trim(c.GetString("password"), " "))
		//3、去数据库匹配
		manager := []models.Manager{}
		models.DB.Where("username=? AND password=? AND status=1", username, password).Find(&manager)
		if len(manager) > 0 {
			//登录成功 1、保存用户信息  2、跳转到后台管理系统
			c.SetSession("userinfo", manager[0])

			c.Success("登录成功", "/")
		} else {
			c.Error("用户名获取密码错误", "/login")
		}

	} else {
		c.Error("验证码错误", "/login")
	}
}

func (c *LoginController) LoginOut() {

	c.DelSession("userinfo")

	c.Success("退出登录成功", "/login")
}
