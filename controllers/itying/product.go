package itying

import (
	"beegoxiaomi/models"
	"fmt"
	"math"
	"strconv"
	"strings"
)

type ProductController struct {
	BaseController
}

func (c *ProductController) Get() {

}
func (c *ProductController) CategoryList() {
	//调用公共功能
	c.SuperInit()

	id := c.Ctx.Input.Param(":id")
	cateId, _ := strconv.Atoi(id)
	curretGoodsCate := models.GoodsCate{}
	subGoodsCate := []models.GoodsCate{}
	models.DB.Where("id=?", cateId).Find(&curretGoodsCate)
	//分类id
	fmt.Println("**********************cateId:", cateId)
	//分页
	//当前页
	page, _ := c.GetInt("page")
	if page == 0 {
		page = 1
	}
	//每一页显示的数量
	pageSize := 5

	var tempSlice []int
	if curretGoodsCate.Pid == 0 { //顶级分类
		//二级分类
		models.DB.Where("pid=?", curretGoodsCate.Id).Find(&subGoodsCate)
		for i := 0; i < len(subGoodsCate); i++ {
			tempSlice = append(tempSlice, subGoodsCate[i].Id)
		}
	} else {
		//获取当前二级分类对应的兄弟分类
		models.DB.Where("pid=?", curretGoodsCate.Pid).Find(&subGoodsCate)
	}
	tempSlice = append(tempSlice, cateId)
	where := "cate_id in (?)"
	goods := []models.Goods{}
	models.DB.Where(where, tempSlice).Select("id,title,price,goods_img").Offset((page - 1) * pageSize).Limit(pageSize).Order("sort desc").Find(&goods)
	//查询goods表里面的数量
	var count int
	models.DB.Where(where, tempSlice).Table("goods").Count(&count)

	c.Data["goodsList"] = goods
	c.Data["subGoodsCate"] = subGoodsCate
	c.Data["curretGoodsCate"] = curretGoodsCate
	c.Data["totalPages"] = math.Ceil(float64(count) / float64(pageSize))
	c.Data["page"] = page

	//指定分类模板
	tpl := curretGoodsCate.Template
	if tpl == "" {
		tpl = "itying/product/list.html"
	}

	c.TplName = tpl
}

func (c *ProductController) Search() {
	c.SuperInit()

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
		where += " AND title like \"%" + keyword + "%\""
	}
	//查询数据
	goodsList := []models.Goods{}
	models.DB.Where(where).Offset((page - 1) * pageSize).Limit(pageSize).Find(&goodsList)

	//判断是否有数据，如果没有数据跳转到首页
	if len(goodsList) == 0 {
		prvPage := page - 1
		if prvPage == 0 {
			prvPage = 1
		}
		c.Redirect("/", 302)

	}

	//查询goods表里面的数量
	var count int
	models.DB.Where(where).Table("goods").Count(&count)

	c.Data["goodsList"] = goodsList
	c.Data["totalPages"] = math.Ceil(float64(count) / float64(pageSize))
	c.Data["page"] = page
	c.Data["keyword"] = keyword
	c.TplName = "itying/product/search.html"

}

func (c *ProductController) ProductItem() {
	c.SuperInit()

	id := c.Ctx.Input.Param(":id")
	//1、获取商品信息
	goods := models.Goods{}
	models.DB.Where("id=?", id).Find(&goods)
	c.Data["goods"] = goods
	c.Data["GoodsID"] = goods.Id

	//2、获取关联商品  RelationGoods
	relationGoods := []models.Goods{}
	goods.RelationGoods = strings.ReplaceAll(goods.RelationGoods, "，", ",")
	relationIds := strings.Split(goods.RelationGoods, ",")
	models.DB.Where("id in (?)", relationIds).Select("id,title,price").Find(&relationGoods)
	c.Data["relationGoods"] = relationGoods

	//3、获取关联赠品 GoodsGift
	goodsGift := []models.Goods{}
	goods.GoodsGift = strings.ReplaceAll(goods.GoodsGift, "，", ",")
	giftIds := strings.Split(goods.GoodsGift, ",")
	models.DB.Where("id in (?)", giftIds).Select("id,title,price,goods_img").Find(&goodsGift)
	c.Data["goodsGift"] = goodsGift

	//4、获取关联颜色 GoodsColor
	goodsColor := []models.GoodsColor{}
	goods.GoodsColor = strings.ReplaceAll(goods.GoodsColor, "，", ",")
	colorIds := strings.Split(goods.GoodsColor, ",")
	models.DB.Where("id in (?)", colorIds).Find(&goodsColor)
	c.Data["goodsColor"] = goodsColor

	//5、获取关联配件 GoodsFitting
	goodsFitting := []models.Goods{}
	goods.GoodsFitting = strings.ReplaceAll(goods.GoodsFitting, "，", ",")
	fittingIds := strings.Split(goods.GoodsFitting, ",")
	models.DB.Where("id in (?)", fittingIds).Select("id,title,price,goods_img").Find(&goodsFitting)
	c.Data["goodsFitting"] = goodsFitting

	//6、获取商品关联的图片 GoodsImage
	goodsImage := []models.GoodsImage{}
	//models.DB.Where("goods_id=?", goods.Id).Limit(6).Find(&goodsImage)
	models.DB.Where("goods_id=?", goods.Id).Limit(6).Find(&goodsImage)
	fmt.Println("***************goods", goods)
	fmt.Println("***************goodsImage", goodsImage)
	c.Data["goodsImage"] = goodsImage

	//7、获取规格参数信息 GoodsAttr
	goodsAttr := []models.GoodsAttr{}
	models.DB.Where("goods_id=?", goods.Id).Find(&goodsAttr)
	c.Data["goodsAttr"] = goodsAttr

	c.TplName = "itying/product/item.html"
}
func (c *ProductController) GetImgList() {
	colorId, err1 := c.GetInt("color_id")
	goodsId, err2 := c.GetInt("goods_id")
	//查询商品图库信息
	goodsImage := []models.GoodsImage{}
	err3 := models.DB.Where("color_id=? AND goods_id=?", colorId, goodsId).Find(&goodsImage).Error

	if err1 != nil || err2 != nil || err3 != nil {
		c.Data["json"] = map[string]interface{}{
			"result":  "失败",
			"success": false,
		}
		c.ServeJSON()
	} else {
		if len(goodsImage) == 0 {
			models.DB.Where("goods_id=?", goodsId).Find(&goodsImage)
		}
		c.Data["json"] = map[string]interface{}{
			"result":  goodsImage,
			"success": true,
		}
		c.ServeJSON()
	}
}
