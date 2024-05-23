package admin

import (
	"beegoxiaomi/models"
	"math"
	"strconv"
)

type UserListController struct {
	BaseController
}

func (c *UserListController) Get() {
	//usertemplist := []models.UserTemp{}
	//models.DB.Find(&usertemplist)
	//c.Data[usertemplist] = usertemplist
	//c.TplName = "admin/userlist/index.html"
	//当前页
	page, _ := c.GetInt("page")
	if page == 0 {
		page = 1
	}
	//每一页显示的数量
	pageSize := 10

	//实现搜索功能
	keyword := c.GetString("keyword")
	where := "1=1"
	if len(keyword) > 0 {
		where += " AND phone like \"%" + keyword + "%\""
	}
	//查询数据
	usertemplist := []models.UserTemp{}
	models.DB.Where(where).Offset((page - 1) * pageSize).Limit(pageSize).Find(&usertemplist)

	//判断是否有数据，如果没有数据跳转到上一页
	if len(usertemplist) == 0 {
		prvPage := page - 1
		if prvPage == 0 {
			prvPage = 1
		}
		c.Goto("/userlist?page=" + strconv.Itoa(prvPage))

	}

	//查询表里面的数量
	var count int
	models.DB.Where(where).Table("user_temp").Count(&count)
	c.Data["usertemplist"] = usertemplist
	c.Data["totalPages"] = math.Ceil(float64(count) / float64(pageSize))
	c.Data["page"] = page
	c.Data["keyword"] = keyword
	c.TplName = "admin/userlist/index.html"
}

func (c *UserListController) Delete() {
	usertemp := []models.UserTemp{}
	models.DB.Find(&usertemp)
	id := c.GetString("id")
	models.DB.Where("id=?", id).Find(&usertemp)
	models.DB.Delete(&usertemp)
	c.Success("删除用户成功", c.Ctx.Request.Referer())
}
