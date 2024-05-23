package routers

import (
	"beegoxiaomi/controllers/admin"
	"beegoxiaomi/middleware"

	beego "github.com/beego/beego/v2/server/web"
)

func init() {

	adminPath, _ := beego.AppConfig.String("adminPath")
	ns :=
		beego.NewNamespace("/"+adminPath,
			//中间件:匹配路由前会执,可以用于权限验证
			//注意引入的包： "github.com/beego/beego/v2/server/web/context"

			//判断用户权限
			beego.NSBefore(middleware.AdminAuth),

			//后台管理
			beego.NSRouter("/", &admin.MainController{}),
			beego.NSRouter("/welcome", &admin.MainController{}, "get:Welcome"),
			beego.NSRouter("/main/changeStatus", &admin.MainController{}, "get:ChangeStatus"),
			beego.NSRouter("/main/editNum", &admin.MainController{}, "get:EditNum"),

			beego.NSRouter("/login", &admin.LoginController{}),
			beego.NSRouter("/login/doLogin", &admin.LoginController{}, "post:DoLogin"),
			beego.NSRouter("/login/loginOut", &admin.LoginController{}, "get:LoginOut"),

			//角色管理
			beego.NSRouter("/role", &admin.RoleController{}),
			beego.NSRouter("/role/add", &admin.RoleController{}, `get:Add`),
			beego.NSRouter("/role/edit", &admin.RoleController{}, `get:Edit`),
			beego.NSRouter("/role/doAdd", &admin.RoleController{}, `post:DoAdd`),
			beego.NSRouter("/role/doEdit", &admin.RoleController{}, `post:DoEdit`),
			beego.NSRouter("/role/delete", &admin.RoleController{}, `get:Delete`),
			beego.NSRouter("/role/auth", &admin.RoleController{}, `get:Auth`),
			beego.NSRouter("/role/doAuth", &admin.RoleController{}, `post:DoAuth`),
			beego.NSRouter("/userlist", &admin.UserListController{}),
			beego.NSRouter("/userlist/delete", &admin.UserListController{}, `get:Delete`),

			//管理员管理
			beego.NSRouter("/manager", &admin.ManagerController{}),
			beego.NSRouter("/manager/add", &admin.ManagerController{}, "get:Add"),
			beego.NSRouter("/manager/edit", &admin.ManagerController{}, "get:Edit"),
			beego.NSRouter("/manager/doAdd", &admin.ManagerController{}, `post:DoAdd`),
			beego.NSRouter("/manager/doEdit", &admin.ManagerController{}, `post:DoEdit`),
			beego.NSRouter("/manager/delete", &admin.ManagerController{}, `get:Delete`),

			//权限管理

			beego.NSRouter("/access", &admin.AccessController{}),
			beego.NSRouter("/access/add", &admin.AccessController{}, "get:Add"),
			beego.NSRouter("/access/edit", &admin.AccessController{}, "get:Edit"),
			beego.NSRouter("/access/doAdd", &admin.AccessController{}, `post:DoAdd`),
			beego.NSRouter("/access/doEdit", &admin.AccessController{}, `post:DoEdit`),
			beego.NSRouter("/access/delete", &admin.AccessController{}, `get:Delete`),

			//轮播图管理
			beego.NSRouter("/focus", &admin.FocusController{}),
			beego.NSRouter("/focus/add", &admin.FocusController{}, `get:Add`),
			beego.NSRouter("/focus/edit", &admin.FocusController{}, `get:Edit`),
			beego.NSRouter("/focus/doAdd", &admin.FocusController{}, `post:DoAdd`),
			beego.NSRouter("/focus/doEdit", &admin.FocusController{}, `post:DoEdit`),
			beego.NSRouter("/focus/delete", &admin.FocusController{}, `get:Delete`),

			//商品分类管理
			beego.NSRouter("/goodsCate", &admin.GoodsCateController{}),
			beego.NSRouter("/goodsCate/add", &admin.GoodsCateController{}, `get:Add`),
			beego.NSRouter("/goodsCate/edit", &admin.GoodsCateController{}, `get:Edit`),
			beego.NSRouter("/goodsCate/doAdd", &admin.GoodsCateController{}, `post:DoAdd`),
			beego.NSRouter("/goodsCate/doEdit", &admin.GoodsCateController{}, `post:DoEdit`),
			beego.NSRouter("/goodsCate/delete", &admin.GoodsCateController{}, `get:Delete`),

			//商品类型属性管理
			beego.NSRouter("/goodsTypeAttribute", &admin.GoodsTypeAttrController{}),
			beego.NSRouter("/goodsTypeAttribute/add", &admin.GoodsTypeAttrController{}, `get:Add`),
			beego.NSRouter("/goodsTypeAttribute/edit", &admin.GoodsTypeAttrController{}, `get:Edit`),
			beego.NSRouter("/goodsTypeAttribute/doAdd", &admin.GoodsTypeAttrController{}, `post:DoAdd`),
			beego.NSRouter("/goodsTypeAttribute/doEdit", &admin.GoodsTypeAttrController{}, `post:DoEdit`),
			beego.NSRouter("/goodsTypeAttribute/delete", &admin.GoodsTypeAttrController{}, `get:Delete`),

			//商品管理
			beego.NSRouter("/goods", &admin.GoodsController{}),
			beego.NSRouter("/goods/add", &admin.GoodsController{}, `get:Add`),
			beego.NSRouter("/goods/edit", &admin.GoodsController{}, `get:Edit`),
			beego.NSRouter("/goods/doAdd", &admin.GoodsController{}, `post:DoAdd`),
			beego.NSRouter("/goods/doEdit", &admin.GoodsController{}, `post:DoEdit`),
			beego.NSRouter("/goods/delete", &admin.GoodsController{}, `get:Delete`),
			beego.NSRouter("/goods/doUpload", &admin.GoodsController{}, `post:DoUpload`),
			beego.NSRouter("/goods/doUploadPhoto", &admin.GoodsController{}, `post:DoUploadPhoto`),
			beego.NSRouter("/goods/getGoodsTypeAttribute", &admin.GoodsController{}, `get:GetGoodsTypeAttribute`),
			beego.NSRouter("/goods/changeGoodsImageColor", &admin.GoodsController{}, `get:ChangeGoodsImageColor`),
			beego.NSRouter("/goods/removeGoodsImage", &admin.GoodsController{}, `get:RemoveGoodsImage`),

			//导航管理
			beego.NSRouter("/nav", &admin.NavController{}),
			beego.NSRouter("/nav/add", &admin.NavController{}, `get:Add`),
			beego.NSRouter("/nav/edit", &admin.NavController{}, `get:Edit`),
			beego.NSRouter("/nav/doAdd", &admin.NavController{}, `post:DoAdd`),
			beego.NSRouter("/nav/doEdit", &admin.NavController{}, `post:DoEdit`),
			beego.NSRouter("/nav/delete", &admin.NavController{}, `get:Delete`),

			//系统设置
			beego.NSRouter("/setting", &admin.SettingController{}),
			beego.NSRouter("/setting/doEdit", &admin.SettingController{}, `post:DoEdit`),

			//订单管理
			beego.NSRouter("/order", &admin.OrderController{}),
			beego.NSRouter("/order/edit", &admin.OrderController{}, `get:Edit`),
			beego.NSRouter("/order/doEdit", &admin.OrderController{}, `post:DoEdit`),
			beego.NSRouter("/order/delete", &admin.OrderController{}, `get:Delete`),

			//数据可视化
			beego.NSRouter("/dataShow", &admin.DataShowController{}),
			beego.NSRouter("/dataShow/bar", &admin.DataShowController{}, `get:CreatBar`),
			beego.NSRouter("/dataShow/pie", &admin.DataShowController{}, `get:CreatePieChart`),
		)

	//注册 namespace
	beego.AddNamespace(ns)
}
