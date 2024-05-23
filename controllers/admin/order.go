package admin

import (
	"beegoxiaomi/models"
	"math"
	"strconv"
)

type OrderController struct {
	BaseController
}

func (c *OrderController) Get() {
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
		where += " AND order_id like \"%" + keyword + "%\""
	}
	//查询数据
	orderList := []models.Order{}
	models.DB.Where(where).Offset((page - 1) * pageSize).Limit(pageSize).Find(&orderList)

	//判断是否有数据，如果没有数据跳转到上一页
	if len(orderList) == 0 {
		prvPage := page - 1
		if prvPage == 0 {
			prvPage = 1
		}
		c.Goto("/order?page=" + strconv.Itoa(prvPage))
	}

	//查询order表里面的数量
	var count int
	models.DB.Where(where).Table("order").Count(&count)

	c.Data["orderList"] = orderList
	c.Data["totalPages"] = math.Ceil(float64(count) / float64(pageSize))
	c.Data["page"] = page
	c.Data["keyword"] = keyword

	c.TplName = "admin/order/index.html"
}

func (c *OrderController) Edit() {

	order_id := c.GetString("order_id")
	order := models.Order{}
	models.DB.Where("order_id=?", order_id).Find(&order)
	c.Data["order"] = order

	c.TplName = "admin/order/edit.html"

}

func (c *OrderController) DoEdit() {

	order_id := c.GetString("order_id")
	name := c.GetString("name")
	all_price, _ := c.GetFloat("all_price")
	address := c.GetString("address")
	pay_status, _ := c.GetInt("pay_status")
	order_status, _ := c.GetInt("order_status")
	order := models.Order{}
	models.DB.Where("order_id=?", order_id).Find(&order)

	order.Name = name
	order.AllPrice = all_price
	order.Address = address
	order.PayStatus = pay_status
	order.OrderStatus = order_status

	err := models.DB.Save(&order).Error
	if err != nil {
		c.Error("修改订单错误", "/order/edit?order_id="+order_id)
	} else {
		c.Success("修改成功", "/order")
	}

}

func (c *OrderController) Delete() {

	id, err1 := c.GetInt("id")
	if err1 != nil {
		c.Error("传入参数错误", "/goods")
		return
	}
	order := models.Order{Id: id}
	err2 := models.DB.Delete(&order).Error
	order_id := order.Uid
	if err2 != nil {
		//删除oder_item表的的订单物品信息
		order_item := models.OrderItem{OrderId: order_id}
		models.DB.Delete(&order_item)
	}
	c.Success("删除商品数据成功", c.Ctx.Request.Referer())

}
