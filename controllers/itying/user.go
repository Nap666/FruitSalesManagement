package itying

import (
	"beegoxiaomi/models"
	"math"
	"strconv"
)

type UserController struct {
	BaseController
}

func (c *UserController) Get() {
	c.SuperInit()

	c.TplName = "itying/user/welcome.html"

}

func (c *UserController) Edit() {

	c.SuperInit()
	id, _ := c.GetInt("id")
	user := models.User{}
	models.Cookie.Get(c.Ctx, "userinfo", &user)
	order := models.Order{}
	models.DB.Where("id=? And uid=?", id, user.Id).Preload("OrderItem").Find(&order)
	c.Data["order"] = order

	c.TplName = "itying/user/edit.html"

}
func (c *UserController) DoEdit() {
	c.SuperInit()

}

func (c *UserController) OrderList() {
	c.SuperInit()
	//1、获取当前用户
	user := models.User{}
	models.Cookie.Get(c.Ctx, "userinfo", &user)

	//2、获取当前用户下面的订单信息 并 分页
	page, _ := c.GetInt("page")
	if page == 0 {
		page = 1
	}
	pageSize := 2

	//获取搜索关键词
	where := "uid=?"
	keywords := c.GetString("keywords")
	if keywords != "" {
		orderItem := []models.OrderItem{}
		models.DB.Where("product_title like ?", "%"+keywords+"%").Find(&orderItem)

		var str string
		for i := 0; i < len(orderItem); i++ {
			if i == 0 {
				str += strconv.Itoa(orderItem[i].OrderId)
			} else {
				str += "," + strconv.Itoa(orderItem[i].OrderId)
			}
		}
		// 2,3,4

		where += " And id in (" + str + ")"

	}
	//获取筛选条件
	orderStatus, statusError := c.GetInt("order_status")
	if statusError == nil {
		where += " And order_status=" + strconv.Itoa(orderStatus)
		c.Data["orderStatus"] = orderStatus
	} else {
		c.Data["orderStatus"] = "nil"
	}

	//总数量
	var count int
	models.DB.Where(where, user.Id).Table("order").Count(&count)

	order := []models.Order{}
	models.DB.Where(where, user.Id).Offset((page - 1) * pageSize).Limit(pageSize).Preload("OrderItem").Order("add_time desc").Find(&order)

	c.Data["order"] = order
	c.Data["totalPages"] = math.Ceil(float64(count) / float64(pageSize))
	c.Data["page"] = page
	c.Data["keywords"] = keywords

	c.TplName = "itying/user/order.html"
}
func (c *UserController) OrderInfo() {
	c.SuperInit()
	id, _ := c.GetInt("id")
	user := models.User{}
	models.Cookie.Get(c.Ctx, "userinfo", &user)
	order := models.Order{}
	models.DB.Where("id=? And uid=?", id, user.Id).Preload("OrderItem").Find(&order)
	c.Data["order"] = order
	if order.OrderId == "" {
		c.Redirect("/", 302)
	}
	c.TplName = "itying/user/order_info.html"
}
