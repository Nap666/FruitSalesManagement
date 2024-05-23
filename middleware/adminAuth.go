package middleware

import (
	"beegoxiaomi/models"
	"net/url"
	"strings"

	beego "github.com/beego/beego/v2/server/web"
	"github.com/beego/beego/v2/server/web/context"
)

func AdminAuth(ctx *context.Context) {

	adminPath, _ := beego.AppConfig.String("adminPath")
	pathname := ctx.Request.URL.String()
	userinfo, ok := ctx.Input.Session("userinfo").(models.Manager) //类型断言

	if !(ok && userinfo.Username != "") { //未登录
		if pathname != "/"+adminPath+"/login" && pathname != "/"+adminPath+"/login/doLogin" {
			ctx.Redirect(302, "/"+adminPath+"/login")
		}
	} else {
		pathname = strings.Replace(pathname, "/"+adminPath, "", 1)
		urlPath, _ := url.Parse(pathname) //urlPath.Path  /role/edit

		//判断管理员是不是超级管理员以及判断排除的url地址
		if userinfo.IsSuper == 0 && !excludeAuthPath(string(urlPath.Path)) {
			// 1、根据角色获取当前角色的权限列表,然后把权限id放在一个map类型的对象里面
			roleId := userinfo.RoleId
			roleAccess := []models.RoleAccess{}
			models.DB.Where("role_id=?", roleId).Find(&roleAccess)
			roleAccessMap := make(map[int]int)
			for _, v := range roleAccess {
				roleAccessMap[v.AccessId] = v.AccessId
			}
			// 2、获取当前访问的url对应的权限id
			/*
				/beego_admin/manager 替换成 /manager
				beego_admin/role/edit?id=11   替换成  /role/edit

				pathname = strings.Replace(pathname, "/"+adminPath, "", 1)
				urlPath, _ := url.Parse(pathname) //urlPath.Path  /role/edit
			*/
			access := models.Access{}
			models.DB.Where("url=?", urlPath.Path).Find(&access)

			//3、判断当前访问的url对应的权限id 是否在权限列表的id中
			if _, ok := roleAccessMap[access.Id]; !ok {
				ctx.WriteString("抱歉，没有权限")
				return
			}
		}

	}
}

// 判断一个url是否在排除的地址里面
func excludeAuthPath(urlPath string) bool {
	excludeAuthPath, _ := beego.AppConfig.String("excludeAuthPath")
	excludeAuthPathSlice := strings.Split(excludeAuthPath, ",")
	for _, v := range excludeAuthPathSlice {
		if v == urlPath {
			return true
		}
	}
	return false
}
