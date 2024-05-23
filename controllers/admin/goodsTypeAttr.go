package admin

import (
	"beegoxiaomi/models"
	"strconv"
	"strings"
)

type GoodsTypeAttrController struct {
	BaseController
}

func (c *GoodsTypeAttrController) Get() {

	cateId, err1 := c.GetInt("cate_id")
	if err1 != nil {
		c.Error("非法请求", "/goodsType")
	}

	//查询当前类型下面的商品类型属性
	goodsTypeAttr := []models.GoodsTypeAttribute{}
	models.DB.Where("cate_id=?", cateId).Find(&goodsTypeAttr)
	c.Data["goodsTypeAttrList"] = goodsTypeAttr

	c.TplName = "admin/goodsTypeAttribute/index.html"
}

func (c *GoodsTypeAttrController) Add() {

	cateId, err1 := c.GetInt("cate_id")
	if err1 != nil {
		c.Error("非法请求", "/goodsType")
	}

	c.Data["cateId"] = cateId
	c.TplName = "admin/goodsTypeAttribute/add.html"
}

func (c *GoodsTypeAttrController) DoAdd() {

	title := c.GetString("title")
	cateId, err1 := c.GetInt("cate_id")
	attrType, err2 := c.GetInt("attr_type")
	attrValue := c.GetString("attr_value")
	sort, err3 := c.GetInt("sort")

	if err1 != nil || err2 != nil {
		c.Error("非法请求", "/goodsType")
		return
	}
	if strings.Trim(title, " ") == "" {
		c.Error("商品类型属性名称不能为空", "/goodsTypeAttribute/add?cate_id="+strconv.Itoa(cateId))
		return
	}

	if err3 != nil {
		c.Error("排序值不对", "/goodsTypeAttribute/add?cate_id="+strconv.Itoa(cateId))
		return
	}
	goodsTypeAttr := models.GoodsTypeAttribute{
		Title:     title,
		CateId:    cateId,
		AttrType:  attrType,
		AttrValue: attrValue,
		Status:    1,
		Sort:      sort,
		AddTime:   int(models.GetUnix()),
	}
	models.DB.Create(&goodsTypeAttr)
	c.Success("增加成功", "/goodsTypeAttribute?cate_id="+strconv.Itoa(cateId))

}

func (c *GoodsTypeAttrController) Edit() {
	// c.Ctx.WriteString("修改")
	id, err1 := c.GetInt("id")
	if err1 != nil {
		c.Error("非法请求", "/goodsType")
		return
	}
	//获取商品类型属性
	goodsTypeAttr := models.GoodsTypeAttribute{Id: id}
	models.DB.Find(&goodsTypeAttr)
	c.Data["goodsTypeAttr"] = goodsTypeAttr

	c.TplName = "admin/goodsTypeAttribute/edit.html"
}

func (c *GoodsTypeAttrController) DoEdit() {

	id, err1 := c.GetInt("id")
	title := c.GetString("title")
	cateId, err2 := c.GetInt("cate_id")
	attrType, err3 := c.GetInt("attr_type")
	attrValue := c.GetString("attr_value")
	sort, err4 := c.GetInt("sort")

	if err1 != nil || err2 != nil || err3 != nil {
		c.Error("非法请求", "/goodsTypeAttribute")
		return
	}
	if strings.Trim(title, " ") == "" {
		c.Error("商品类型属性名称不能为空", "/goodsTypeAttribute/edit?id="+strconv.Itoa(id))
		return
	}
	if err4 != nil {
		c.Error("排序值不对", "/goodsTypeAttribute/edit?id="+strconv.Itoa(id))
		return
	}
	goodsTypeAttr := models.GoodsTypeAttribute{Id: id}
	models.DB.Find(&goodsTypeAttr)
	goodsTypeAttr.Title = title
	goodsTypeAttr.CateId = cateId
	goodsTypeAttr.AttrType = attrType
	goodsTypeAttr.AttrValue = attrValue
	goodsTypeAttr.Sort = sort

	err := models.DB.Save(&goodsTypeAttr).Error
	if err != nil {
		c.Error("修改数据失败", "/goodsTypeAttribute/edit?id="+strconv.Itoa(id))
		return
	}
	c.Success("需改数据成功", "/goodsTypeAttribute?cate_id="+strconv.Itoa(cateId))

}

func (c *GoodsTypeAttrController) Delete() {

	id, err1 := c.GetInt("id")
	cateId, err2 := c.GetInt("cate_id")
	if err1 != nil {
		c.Error("传入参数错误", "/goodsTypeAttribute?cate_id="+strconv.Itoa(cateId))
		return
	}
	if err2 != nil {
		c.Error("传入参数错误", "/goodsType")
		return
	}

	goodsTypeAttr := models.GoodsTypeAttribute{Id: id}
	models.DB.Delete(&goodsTypeAttr)
	c.Success("删除数据成功", "/goodsTypeAttribute?cate_id="+strconv.Itoa(cateId))
}
