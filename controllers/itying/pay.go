package itying

import (
	"beegoxiaomi/models"
	"fmt"
	"strings"
	"time"

	"github.com/beego/beego/v2/core/logs"
	"github.com/objcoding/wxpay"
	qrcode "github.com/skip2/go-qrcode"
	"github.com/smartwalle/alipay/v3"
)

type PayController struct {
	BaseController
}

func (c *PayController) OrderOK() {
	order_id := c.GetString("id")
	fmt.Println("*****************order_id:", order_id)
	order := models.Order{}
	models.DB.Where("order_id=?", order_id).Find(&order)
	order.PayStatus = 1
	order.OrderStatus = 1

	models.DB.Save(&order)
	c.Redirect("/user/order", 302)
}

func (c *PayController) Alipay() {
	var privateKey = "MIIEowIBAAKCAQEAmZlUXdYU5qhpSe7bmv+NAEQehXq2wkV2pAhr9zU2fKJSB77V1Z9079SYTs0yGX3XpGKqVYVGZu6F3js9QX1/PPfELHrxOa4mHXQz+TryniXx1e1ng4kDedy1SyS8xTBeGCvReIqAtMUeAo/hedgvdtgYEvY5hZqbV7b3zEpEkq/XgvgaH5nmYR/fDnocwQt5OpDlXNGMrfhU4g0nvQHzb8Kcd2YSjkDB37o/yV9i0Wq8vJqPdWCJOGxCOafy1Qt1VfPF6s9h/9V8mWTGrMGyaUUgz/0ILdlt/bHzRSR9K5qa0x9mEfnGZRj14x3WGIlNfSmS88a4wR0iXP+UtEASXwIDAQABAoIBABoUDV3tNhk/aLjzw/daAh+UcTYqcpMjZhRNlb8gGsMocBL+lKGzdBAwITfn4OSxGAbB9beVbDGXt8TWe/z9iLfaPUVsDj7D0ZbYnuZm2sB9IsU2jIepoJx1G5bJgv9bye4CqorzwQxwFztKIHcmfFCKOfQmN/f2Gv/WgdX+mgvpaNPfHn3gnnNpmhq2Mb8QiNhLvPMhKXORk08a2xGLUEO43Iw7YSg8lZ4L6So/ROSPCtyErAgVTxAkfKoFyJAaHykKPeeLt9Zy5aPndmizIWwCMXb0+Zq7bDmKS3yvq8Nr95ZjOc09GD1nit2vWLCPJxNc2lzkSBxIAmDmXta0+LECgYEA6LMl02AgB47zxXfvhDSpW3SABrzU8GyOnZjcYdf2cZkDtgx0QE3g5E2YeWFcSny3+x3ug6nVjjIscZaBap3DxwMft2PrGX7Bfmecg3hJ+TF7KLFuAkmG+qqzkPeox9YTs/aRBRVBu9oo+Io44HqryIoehCpX59+CjqznhLEX8FcCgYEAqPqR3wJPI38XqGLKoxpI20l99rGD/mj2J3PvFXGtti3e5ZB4irsxO8U38vHEw/2kEXEJZW+2trS486pXaKE8JfrRItjaCUbgUSO+3lCpdkl9gXfimEr0xD2zPf92aAcxqQiG65I+k2Ch5ba2YmteTGi55SB6FuEAvHtGhRf7iTkCgYEAlFQ1pVJduFOwIcx8uaoT1j8hqKnPll2sXtrkh93wsqKV0gKIS8EYvI6VxbGA8d4kLIb81aJ5hUWIPPNyFTLxa7cbDXw8jSjWUCvdgZQ4mwamed73v698weXzxlGHnbJhJtLhx/qvxv2eJid9b+HiBFe+cgLHu/8mKqoefd+g4csCgYAAsOWfz9abAo4KNj015Ymeu/Iz7A3qIGvBRYwYvlpDgHSE485aYuGUqP3NlIeFdagSGjA7pfVNUfffpzasStyAG0J3rgNWPl/0dPz208WdojdNLDxU+xl9I/NzsXO+gSkG0+4ZUIPI/oAq/FBKnr3H+jWoZjWZmlnya16idLKmoQKBgEU5tCv8klIdPLwHu0UOrMWtbPnWABzCu2eJdova0zJblHE5KTgu3U2td/wEfiDJVYpnK3XSZkxhjJWKxxtWSQwUjZwK00pc2J/wxW1wPq7uXI0/jiJT/C4BDwDor20wMm8hqOgdCxPT1yIbD25WUF7QVRBUuX/wQHJfdrsPKzUe" // 必须，上一步中使用 RSA签名验签工具 生成的私钥
	var client, _ = alipay.New("2021001144694156", privateKey, true)

	client.LoadAppPublicCertFromFile("./crt/appCertPublicKey_2021001186696588.crt") // 加载应用公钥证书
	client.LoadAliPayRootCertFromFile("./crt/alipayRootCert.crt")                   // 加载支付宝根证书
	client.LoadAliPayPublicCertFromFile("./crt/alipayCertPublicKey_RSA2.crt")       // 加载支付宝公钥证书

	var p = alipay.TradePagePay{}
	p.NotifyURL = "http://pay.apiying.com/alipayNotify"
	p.ReturnURL = "http://pay.apiying.com/alipayReturn"
	p.Subject = "这是一个beego订单"
	p.OutTradeNo = "222214142" + models.GetRandomNum() + models.GetRandomNum()
	p.TotalAmount = "0.1"
	p.ProductCode = "FAST_INSTANT_TRADE_PAY"

	var url, err4 = client.TradePagePay(p)
	if err4 != nil {
		fmt.Println(err4)
	}
	var payURL = url.String()
	fmt.Println(payURL)
	c.Redirect(payURL, 302)
	c.Ctx.WriteString("支付宝支付")

}

func (c *PayController) AlipayNotify() {

	var privateKey = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCPUi2yj4RJcqAKfjV/AxjqIjjUq007pGhLClbrwEoCVhgnQU9bAVFnPlDaVdO2xBfu8D/gHCwV9czZKJh51yg1kwE6Yv/hSd966PnGS9NszfxxWfTbWeC6DIHZj66nTECK+vYWX36tKxIG+juzXyfoAuyL1h58oFgF/Zwa1FzpKDTcMUIE+npf3DpMS0Uatf6TsREzVQQs3i0WVxYY3lv1Dmualr6Q3GAFE1j/xt/STE993uh8MVeLS+RcTrrjilPSVH5Z0DLAjkDSH7XUK1lIHASpgOrddEJ8MeT8L7bUJ8nDs5qQ8zfbPVJaXfsF2NYS162HkIW2bl0r5c5Mudt7AgMBAAECggEAWUHVweHNgiyH7WECkhJsvswHVrNEi0NtzGYpEfOUY/YYXsI22Lduaf0OP5u6GZXwTdeEAF+rORX2uLumkiLkINFnr2QedcEbFCHqBIwOpTF36WQbsUw9P8EwUT1BiWFcxPFctzxL2S78sCnBaol1gfHoPYJhRD5b84cpZDAjmPSJk1XAtAtKChUIskLBAsCvwlGHbx/6UQwM9eKgwo0Y67MCPW9wBjE9bRFWBfaeLszEVu3nKyOKLwcUGDXrbmBS8bj9YtyqTG7RjKZmIGuJtPKehEjlNn2ALYYMHUA5VSdVP4LrBiLVLQE5tTDedAzr3uHuWOgLaMeDnfwQg8Hj6QKBgQDGaCoZ3JRg4PbGetduHpGfWOstwZKNwqkDeYvpA03GcRYhzhqG98qdTGEYaLGkszQrh0ZcYk7fs8jsR5Lu2WTzImtiAYDCDEjSDHj5N5PfWR0r2pxrUvX8shun4QKpz4QQ0RUjeujZ2hJHkeCviF2+k5IBDvz6YtBo+H3IgR9QjwKBgQC47IVtuvlYZ0/2TAcAt40YhEgLZOr3NuR4eSnx76zf/8vRmHDEfIqvUdIzzJy3RVYT3uXiB7DYwaHr76ouP3lMOhgLgUlK4Dt8L3UbMP6Asr+6D/uggVmlIHKK76HZIdBL5nGQvTOvwE+fmEivlR5QV+cczqQdCYyNZXETmgAkVQKBgF32JMIcqZR71cLHmFDJX1Okq7P+sWY7YwmHPZA7hVDOa5nU3tE+dpEqA+2oX0DNsY5PwS2tTQc6QJRNjTNadymCCnLenVjIso/vYjc8b+ZdcKg9HsjhACgNPXWy5S0AXt4L9sPXyICreu60EkFvBl5jysh/jaUSuPqNfBxBsk/XAoGBAKYxkzzp4/wKZXfSHh0L2VemUuVCnlTtVWncYtEXeQObbX8CBJ7h2vXzj/mTs2iWfOTA11NLXCmB5FcZfpWv4ACc2U1FtSwA2BUkxZdZcfESNHMwuBEpDvrzbV3mPUvaMsxz366YC+Kw8B5biz+ZwbOtPHzMTfv2wAW3nGdkaSo9AoGBALW8kQ6QwXu3gB7q8Es1zCvSg07tnJks57nJDTtOOg6oc52RvKjndWHT6aFwp/YrESeHNvoudRhPm5nKUTbKDiLixDXcrvEU3b70dJGwWHkBdYU/s5J2o5oaclwiyiUptnIp2eA+Cu+wH1eREGmrOAdeBSFOfdjcfJTFmOCoalJR" // 必须，上一步中使用 RSA签名验签工具 生成的私钥
	var client, err = alipay.New("2021001186696588", privateKey, true)

	client.LoadAppPublicCertFromFile("crt/appCertPublicKey_2021001186696588.crt") // 加载应用公钥证书
	client.LoadAliPayRootCertFromFile("crt/alipayRootCert.crt")                   // 加载支付宝根证书
	client.LoadAliPayPublicCertFromFile("crt/alipayCertPublicKey_RSA2.crt")       // 加载支付宝公钥证书

	req := c.Ctx.Request
	req.ParseForm()
	err = client.VerifySign(req.Form)

	logs.Info(err)

	logs.Info(req.Form)
	c.Ctx.WriteString("ok")
}
func (c *PayController) AlipayReturn() {
	c.Ctx.WriteString("支付成功")
}

func (c *PayController) WxPay() {

	//1、配置基本信息
	account := wxpay.NewAccount(
		"wx7bf3787c783116e4",
		"1502539541",
		"zhongyuantengitying6666666666666",
		false,
	)
	client := wxpay.NewClient(account)

	//2、获取ip地址   订单号等信息
	ip := strings.Split(c.Ctx.Request.RemoteAddr, ":")[0]
	template := "200601021504"
	tradeNo := time.Now().Format(template)
	//3、调用统一下单
	params := make(wxpay.Params)
	params.SetString("body", "beego微信支付11").
		SetString("out_trade_no", tradeNo).
		SetInt64("total_fee", 1).
		SetString("spbill_create_ip", ip).
		SetString("notify_url", "http://pay.apiying.com/wxpay/notify").
		// SetString("trade_type", "APP")
		SetString("trade_type", "NATIVE") //网站支付需要改为NATIVE

	p, err1 := client.UnifiedOrder(params)
	if err1 != nil {
		logs.Error(err1)
	}
	//4、获取code_url 生成支付二维码

	var pngObj []byte
	pngObj, _ = qrcode.Encode(p["code_url"], qrcode.Medium, 256)
	c.Ctx.WriteString(string(pngObj))
}

func (c *PayController) WxPayNotify() {
	//1、获取表单传过来的xml数据  在配置文件里设置 copyrequestbody = true
	xmlStr := string(c.Ctx.Input.RequestBody)
	postParams := wxpay.XmlToMap(xmlStr)
	logs.Info(postParams)

	//2、校验签名
	account := wxpay.NewAccount(
		"wx7bf3787c783116e4",
		"1502539541",
		"zhongyuantengitying6666666666666",
		false,
	)
	client := wxpay.NewClient(account)
	isValidate := client.ValidSign(postParams)
	logs.Info(isValidate)

	//3、更新订单
	c.Ctx.WriteString("Ok")
}
