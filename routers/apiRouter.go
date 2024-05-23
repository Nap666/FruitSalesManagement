package routers

import (
	"beegoxiaomi/controllers/api"

	beego "github.com/beego/beego/v2/server/web"
)

func init() {
	ns :=
		beego.NewNamespace("/api",

			beego.NSRouter("/login", &api.LoginController{}),
		)
	//注册 namespace
	beego.AddNamespace(ns)
}
