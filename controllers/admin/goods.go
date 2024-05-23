package admin

import (
	"beegoxiaomi/models"
	"fmt"
	"math"
	"strconv"
	"strings"
	"sync"

	"github.com/beego/beego/v2/core/logs"
	beego "github.com/beego/beego/v2/server/web"
)

var wg sync.WaitGroup

type GoodsController struct {
	BaseController
}

func (c *GoodsController) Get() {

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

	//判断是否有数据，如果没有数据跳转到上一页
	if len(goodsList) == 0 {
		prvPage := page - 1
		if prvPage == 0 {
			prvPage = 1
		}
		c.Goto("/goods?page=" + strconv.Itoa(prvPage))

	}

	//查询goods表里面的数量
	var count int
	models.DB.Where(where).Table("goods").Count(&count)

	c.Data["goodsList"] = goodsList
	c.Data["totalPages"] = math.Ceil(float64(count) / float64(pageSize))
	c.Data["page"] = page
	c.Data["keyword"] = keyword
	c.TplName = "admin/goods/index.html"
}

func (c *GoodsController) Add() {

	//获取商品分类
	goodsCate := []models.GoodsCate{}
	models.DB.Where("pid=?", 0).Preload("GoodsCateItem").Find(&goodsCate)
	c.Data["goodsCateList"] = goodsCate
	logs.Info(goodsCate)

	//获取颜色信息
	goodsColor := []models.GoodsColor{}
	models.DB.Find(&goodsColor)
	c.Data["goodsColor"] = goodsColor

	c.TplName = "admin/goods/add.html"
}

func (c *GoodsController) DoAdd() {
	//1、获取表单提交过来的数据
	title := c.GetString("title")
	goodsSn := c.GetString("goods_sn")
	cateId, _ := c.GetInt("cate_id")
	goodsNumber, _ := c.GetInt("goods_number")
	marketPricestr := c.GetString("market_price")
	pricestr := c.GetString("price")
	relationGoods := c.GetString("relation_goods")
	goodsAttr := c.GetString("goods_attr")
	goodsGift := c.GetString("goods_gift")
	goodsFitting := c.GetString("goods_fitting")
	goodsColor := c.GetStrings("goods_color")
	goodsKeywords := c.GetString("goods_keywords")
	goodsDesc := c.GetString("goods_desc")
	goodsContent := c.GetString("goods_content")
	isDelete, _ := c.GetInt("is_delete")
	isHot, _ := c.GetInt("is_hot")
	isBest, _ := c.GetInt("is_best")
	isNew, _ := c.GetInt("is_new")
	goodsTypeId, _ := c.GetInt("goods_type_id")
	sort, _ := c.GetInt("sort")
	status, _ := c.GetInt("status")
	addTime := int(models.GetUnix())
	//合法性检测
	if title == "" {
		c.Error("商品名称不能为空", "/goods/add")
		return
	}
	marketPrice, err11 := strconv.ParseFloat(marketPricestr, 64)
	price, err12 := strconv.ParseFloat(pricestr, 64)
	if err11 != nil || err12 != nil {
		c.Error("商品价格只能是数字", "/goods/add")
		return
	}
	//2、获取颜色信息 把颜色转化成字符串
	goodsColorStr := strings.Join(goodsColor, ",")

	//3、上传图片   生成缩略图
	goodsImg, err1 := c.UploadImg("goods_img")
	if err1 == nil && len(goodsImg) > 0 {
		//生成缩略图
		ossStatus, _ := beego.AppConfig.Bool("ossStatus")
		if !ossStatus {
			wg.Add(1)
			go func() {
				models.ResizeImage(goodsImg)
				wg.Done()
			}()
		}
	}

	//4、增加商品数据
	goods := models.Goods{
		Title:         title,
		GoodsSn:       goodsSn,
		CateId:        cateId,
		ClickCount:    100,
		GoodsNumber:   goodsNumber,
		MarketPrice:   marketPrice,
		Price:         price,
		RelationGoods: relationGoods,
		GoodsAttr:     goodsAttr,
		GoodsGift:     goodsGift,
		GoodsFitting:  goodsFitting,
		GoodsKeywords: goodsKeywords,
		GoodsDesc:     goodsDesc,
		GoodsContent:  goodsContent,
		IsDelete:      isDelete,
		IsHot:         isHot,
		IsBest:        isBest,
		IsNew:         isNew,
		GoodsTypeId:   goodsTypeId,
		Sort:          sort,
		Status:        status,
		AddTime:       addTime,
		GoodsColor:    goodsColorStr,
		GoodsImg:      goodsImg,
	}

	err2 := models.DB.Create(&goods).Error
	if err2 != nil {
		c.Error("增加失败", "/goods/add")
	}
	//5、增加图库 信息
	wg.Add(1)
	go func() {
		goodsImageList := c.GetStrings("goods_image_list")
		for _, v := range goodsImageList {
			goodsImgObj := models.GoodsImage{}
			goodsImgObj.GoodsId = goods.Id
			goodsImgObj.ImgUrl = v
			goodsImgObj.Sort = 10
			goodsImgObj.Status = 1
			goodsImgObj.AddTime = int(models.GetUnix())
			models.DB.Create(&goodsImgObj)
		}
		wg.Done()
	}()

	//6、增加规格包装
	wg.Add(1)
	go func() {
		attrIdList := c.GetStrings("attr_id_list")
		attrValueList := c.GetStrings("attr_value_list")
		for i := 0; i < len(attrIdList); i++ {
			goodsTypeAttributeId, _ := strconv.Atoi(attrIdList[i])
			goodsTypeAttributeObj := models.GoodsTypeAttribute{Id: goodsTypeAttributeId}
			models.DB.Find(&goodsTypeAttributeObj)

			goodsAttrObj := models.GoodsAttr{}
			goodsAttrObj.GoodsId = goods.Id
			goodsAttrObj.AttributeTitle = goodsTypeAttributeObj.Title
			goodsAttrObj.AttributeType = goodsTypeAttributeObj.AttrType
			goodsAttrObj.AttributeId = goodsTypeAttributeObj.Id
			goodsAttrObj.AttributeCateId = goodsTypeAttributeObj.CateId
			goodsAttrObj.AttributeValue = attrValueList[i]
			goodsAttrObj.Status = 1
			goodsAttrObj.Sort = 10
			goodsAttrObj.AddTime = int(models.GetUnix())
			models.DB.Create(&goodsAttrObj)
		}
		wg.Done()
	}()

	wg.Wait()
	c.Success("增加数据成功", "/goods")

}
func (c *GoodsController) Edit() {

	// 1、获取商品数据
	id, err1 := c.GetInt("id")
	if err1 != nil {
		c.Error("非法请求", "/goods")
	}
	goods := models.Goods{Id: id}
	models.DB.Find(&goods)
	c.Data["goods"] = goods

	//2、获取商品分类
	goodsCate := []models.GoodsCate{}
	models.DB.Where("pid=?", 0).Preload("GoodsCateItem").Find(&goodsCate)
	c.Data["goodsCateList"] = goodsCate

	// 3、获取所有颜色 以及选中的颜色
	goodsColorSlice := strings.Split(goods.GoodsColor, ",")
	goodsColorMap := make(map[string]string)
	for _, v := range goodsColorSlice {
		goodsColorMap[v] = v
	}
	//获取颜色信息
	goodsColor := []models.GoodsColor{}
	models.DB.Find(&goodsColor)
	for i := 0; i < len(goodsColor); i++ {
		_, ok := goodsColorMap[strconv.Itoa(goodsColor[i].Id)]
		if ok {
			goodsColor[i].Checked = true
		}
	}
	c.Data["goodsColor"] = goodsColor

	//4、商品的图库信息
	goodsImage := []models.GoodsImage{}
	models.DB.Where("goods_id=?", goods.Id).Find(&goodsImage)
	c.Data["goodsImage"] = goodsImage

	//6、获取规格信息
	goodsAttr := []models.GoodsAttr{}
	models.DB.Where("goods_id=?", goods.Id).Find(&goodsAttr)

	var goodsAttrStr string
	for _, v := range goodsAttr {
		if v.AttributeType == 1 {
			goodsAttrStr += fmt.Sprintf(`<li><span>%v: 　</span>  <input type="hidden" name="attr_id_list" value="%v" />   <input type="text" name="attr_value_list" value="%v" /></li>`, v.AttributeTitle, v.AttributeId, v.AttributeValue)
		} else if v.AttributeType == 2 {
			goodsAttrStr += fmt.Sprintf(`<li><span>%v: 　</span><input type="hidden" name="attr_id_list" value="%v" />  <textarea cols="50" rows="3" name="attr_value_list">%v</textarea></li>`, v.AttributeTitle, v.AttributeId, v.AttributeValue)
		} else {

			// 获取 attr_value  获取可选值列表
			oneGoodsTypeAttribute := models.GoodsTypeAttribute{Id: v.AttributeId}
			models.DB.Find(&oneGoodsTypeAttribute)
			attrValueSlice := strings.Split(oneGoodsTypeAttribute.AttrValue, "\n")
			goodsAttrStr += fmt.Sprintf(`<li><span>%v: 　</span>  <input type="hidden" name="attr_id_list" value="%v" /> `, v.AttributeTitle, v.AttributeId)
			goodsAttrStr += fmt.Sprintf(`<select name="attr_value_list">`)
			for j := 0; j < len(attrValueSlice); j++ {
				if attrValueSlice[j] == v.AttributeValue {
					goodsAttrStr += fmt.Sprintf(`<option value="%v" selected >%v</option>`, attrValueSlice[j], attrValueSlice[j])
				} else {
					goodsAttrStr += fmt.Sprintf(`<option value="%v">%v</option>`, attrValueSlice[j], attrValueSlice[j])
				}
			}
			goodsAttrStr += fmt.Sprintf(`</select>`)
			goodsAttrStr += fmt.Sprintf(`</li>`)
		}
	}

	c.Data["goodsAttrStr"] = goodsAttrStr
	//上一页地址
	c.Data["prevPage"] = c.Ctx.Request.Referer()
	c.TplName = "admin/goods/edit.html"
}

func (c *GoodsController) DoEdit() {

	//1、获取要修改的商品数据
	id, err1 := c.GetInt("id")
	if err1 != nil {
		c.Error("非法请求", "/goods")
	}
	title := c.GetString("title")
	goodsSn := c.GetString("goods_sn")
	cateId, _ := c.GetInt("cate_id")
	goodsNumber, _ := c.GetInt("goods_number")
	marketPricestr := c.GetString("market_price")
	pricestr := c.GetString("price")
	relationGoods := c.GetString("relation_goods")
	goodsAttr := c.GetString("goods_attr")
	goodsGift := c.GetString("goods_gift")
	goodsFitting := c.GetString("goods_fitting")
	goodsColor := c.GetStrings("goods_color")
	goodsKeywords := c.GetString("goods_keywords")
	goodsDesc := c.GetString("goods_desc")
	goodsContent := c.GetString("goods_content")
	isDelete, _ := c.GetInt("is_delete")
	isHot, _ := c.GetInt("is_hot")
	isBest, _ := c.GetInt("is_best")
	isNew, _ := c.GetInt("is_new")
	goodsTypeId, _ := c.GetInt("goods_type_id")
	sort, _ := c.GetInt("sort")
	status, _ := c.GetInt("status")

	//合法性检测
	if title == "" {
		c.Error("商品名称不能为空", "/goods/edit")
		return
	}
	marketPrice, err11 := strconv.ParseFloat(marketPricestr, 64)
	price, err12 := strconv.ParseFloat(pricestr, 64)
	if err11 != nil || err12 != nil {
		c.Error("商品价格只能是数字", "/goods/edit")
		return
	}
	//获取修改页面上一页的地址
	prevPage := c.GetString("prevPage")

	//2、获取颜色信息 把颜色转化成字符串
	goodsColorStr := strings.Join(goodsColor, ",")

	goods := models.Goods{Id: id}
	models.DB.Find(&goods)
	goods.Title = title
	goods.GoodsSn = goodsSn
	goods.CateId = cateId
	goods.GoodsNumber = goodsNumber
	goods.MarketPrice = marketPrice
	goods.Price = price
	goods.RelationGoods = relationGoods
	goods.GoodsAttr = goodsAttr
	goods.GoodsGift = goodsGift
	goods.GoodsFitting = goodsFitting
	goods.GoodsKeywords = goodsKeywords
	goods.GoodsDesc = goodsDesc
	goods.GoodsContent = goodsContent
	goods.IsDelete = isDelete
	goods.IsHot = isHot
	goods.IsBest = isBest
	goods.IsNew = isNew
	goods.GoodsTypeId = goodsTypeId
	goods.Sort = sort
	goods.Status = status
	goods.GoodsColor = goodsColorStr

	//3、上传图片   生成缩略图
	goodsImg, err2 := c.UploadImg("goods_img")

	if err2 == nil && len(goodsImg) > 0 {
		goods.GoodsImg = goodsImg
		//处理图片
		ossStatus, _ := beego.AppConfig.Bool("ossStatus")
		if !ossStatus {
			wg.Add(1)
			go func() {
				models.ResizeImage(goodsImg)
				wg.Done()
			}()
		}
	}
	//4、执行修改商品
	err3 := models.DB.Save(&goods).Error
	if err3 != nil {
		c.Error("修改数据失败", "/goods/edit?id="+strconv.Itoa(id))
		return
	}
	//5、修改图库数据 （增加）
	wg.Add(1)
	go func() {
		goodsImageList := c.GetStrings("goods_image_list")
		for _, v := range goodsImageList {
			goodsImgObj := models.GoodsImage{}
			goodsImgObj.GoodsId = goods.Id
			goodsImgObj.ImgUrl = v
			goodsImgObj.Sort = 10
			goodsImgObj.Status = 1
			goodsImgObj.AddTime = int(models.GetUnix())
			models.DB.Create(&goodsImgObj)
		}
		wg.Done()
	}()

	//6、修改商品类型属性数据         1、删除当前商品id对应的类型属性  2、执行增加

	//删除当前商品id对应的类型属性
	goodsAttrObj := models.GoodsAttr{}
	models.DB.Where("goods_id=?", goods.Id).Delete(&goodsAttrObj)
	//执行增加
	wg.Add(1)
	go func() {
		attrIdList := c.GetStrings("attr_id_list")
		attrValueList := c.GetStrings("attr_value_list")
		for i := 0; i < len(attrIdList); i++ {
			goodsTypeAttributeId, _ := strconv.Atoi(attrIdList[i])
			goodsTypeAttributeObj := models.GoodsTypeAttribute{Id: goodsTypeAttributeId}
			models.DB.Find(&goodsTypeAttributeObj)

			goodsAttrObj := models.GoodsAttr{}
			goodsAttrObj.GoodsId = goods.Id
			goodsAttrObj.AttributeTitle = goodsTypeAttributeObj.Title
			goodsAttrObj.AttributeType = goodsTypeAttributeObj.AttrType
			goodsAttrObj.AttributeId = goodsTypeAttributeObj.Id
			goodsAttrObj.AttributeCateId = goodsTypeAttributeObj.CateId
			goodsAttrObj.AttributeValue = attrValueList[i]
			goodsAttrObj.Status = 1
			goodsAttrObj.Sort = 10
			goodsAttrObj.AddTime = int(models.GetUnix())
			models.DB.Create(&goodsAttrObj)
		}
		wg.Done()
	}()

	wg.Wait()

	c.Success("修改数据成功", prevPage)
}
func (c *GoodsController) Delete() {

	id, err1 := c.GetInt("id")
	if err1 != nil {
		c.Error("传入参数错误", "/goods")
		return
	}
	goods := models.Goods{Id: id}
	err2 := models.DB.Delete(&goods).Error
	if err2 != nil {
		//删除属性
		goodsAttr := models.GoodsAttr{GoodsId: id}
		models.DB.Delete(&goodsAttr)
		//删除图库信息
		goodsImage := models.GoodsImage{GoodsId: id}
		models.DB.Delete(&goodsImage)
		// os.Remove()
	}
	c.Success("删除商品数据成功", c.Ctx.Request.Referer())

}

// 给富文本编辑器上传图片
func (c *GoodsController) DoUpload() {

	ossDomain, _ := beego.AppConfig.String("ossDomain")

	savePath, err := c.UploadImg("file")
	if err != nil {
		logs.Error("失败")
		c.Data["json"] = map[string]interface{}{
			"link": "",
		}
		c.ServeJSON()
	} else {
		//生成缩略图
		ossStatus, _ := beego.AppConfig.Bool("ossStatus")
		if !ossStatus {
			models.ResizeImage(savePath)
		}
		//返回json数据 {link: 'path/to/image.jpg'}
		if ossStatus {
			c.Data["json"] = map[string]interface{}{
				"link": ossDomain + "/" + savePath,
			}

		} else {
			c.Data["json"] = map[string]interface{}{
				"link": "/" + savePath,
			}
		}

		c.ServeJSON()
	}

}

// 给图库上传图片
func (c *GoodsController) DoUploadPhoto() {

	savePath, err := c.UploadImg("file")
	if err != nil {
		logs.Error("失败")
		c.Data["json"] = map[string]interface{}{
			"link": "",
		}
		c.ServeJSON()
	} else {
		//生成缩略图
		ossStatus, _ := beego.AppConfig.Bool("ossStatus")
		if !ossStatus {
			models.ResizeImage(savePath)
		}
		c.Data["json"] = map[string]interface{}{
			"link": savePath,
		}
		c.ServeJSON()
	}

}

// 获取商品类型属性
func (c *GoodsController) GetGoodsTypeAttribute() {
	cate_id, err1 := c.GetInt("cate_id")
	GoodsTypeAttribute := []models.GoodsTypeAttribute{}
	err2 := models.DB.Where("cate_id=?", cate_id).Find(&GoodsTypeAttribute).Error
	if err1 != nil || err2 != nil {
		c.Data["json"] = map[string]interface{}{
			"result":  "",
			"success": false,
		}
		c.ServeJSON()

	} else {
		c.Data["json"] = map[string]interface{}{
			"result":  GoodsTypeAttribute,
			"success": true,
		}
		c.ServeJSON()
	}

}

// 修改图片对应颜色信息
func (c *GoodsController) ChangeGoodsImageColor() {
	colorId, err1 := c.GetInt("color_id")
	goodsImageId, err2 := c.GetInt("goods_image_id")
	goodsImage := models.GoodsImage{Id: goodsImageId}
	models.DB.Find(&goodsImage)
	goodsImage.ColorId = colorId
	err3 := models.DB.Save(&goodsImage).Error

	if err1 != nil || err2 != nil || err3 != nil {
		c.Data["json"] = map[string]interface{}{
			"result":  "更新失败",
			"success": false,
		}
		c.ServeJSON()
	} else {
		c.Data["json"] = map[string]interface{}{
			"result":  "更新成功",
			"success": true,
		}
		c.ServeJSON()
	}
}

// 删除图库
func (c *GoodsController) RemoveGoodsImage() {
	goodsImageId, err1 := c.GetInt("goods_image_id")
	goodsImage := models.GoodsImage{Id: goodsImageId}
	err2 := models.DB.Delete(&goodsImage).Error
	//   /static/upload/20200622/1592799750042592100.jpg

	if err1 != nil || err2 != nil {
		c.Data["json"] = map[string]interface{}{
			"result":  "删除失败",
			"success": false,
		}
		c.ServeJSON()
	} else {
		//删除图片
		// os.Remove()
		c.Data["json"] = map[string]interface{}{
			"result":  "删除",
			"success": true,
		}
		c.ServeJSON()
	}

}
