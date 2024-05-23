package admin

import (
	"beegoxiaomi/models"
	"github.com/go-echarts/go-echarts/v2/charts"
	"github.com/go-echarts/go-echarts/v2/opts"
	"os"
)

type DataShowController struct {
	BaseController
}

func (c *BaseController) Get() {
	c.TplName = "admin/datashow/index.html"
}

func (c *BaseController) CreatBar() {
	// create a new bar instance
	bar := charts.NewBar()

	// Set global options
	bar.SetGlobalOptions(charts.WithTitleOpts(opts.Title{
		Title: "销售数据",
	}))
	goodsSaleNums := []models.GoodsSaleNum{}
	models.DB.Find(&goodsSaleNums)
	X_str := []string{}
	// 打印查询结果
	for _, goodsSaleNum := range goodsSaleNums {
		var goods models.Goods
		models.DB.First(&goods, goodsSaleNum.GoodsId)
		//fmt.Printf("GoodsId: %d, Title: %s\n", goodsSaleNum.GoodsId, goods.Title)
		X_str = append(X_str, goods.Title)
	}
	// Put data into instance
	items := make([]opts.BarData, 0)
	for i := 0; i < 10; i++ {
		items = append(items, opts.BarData{Value: goodsSaleNums[i].SaledNum})
	}
	bar.SetXAxis(X_str).
		AddSeries("销量(斤)", items)

	f, _ := os.Create("views/admin/datashow/bar.html")
	_ = bar.Render(f)
	c.TplName = "admin/datashow/bar.html"
}

func (c *BaseController) CreatePieChart() {
	// create a new pie instance
	pie := charts.NewPie()
	pie.SetGlobalOptions(
		charts.WithTitleOpts(
			opts.Title{
				Title: "Pie chart",
			},
		),
	)
	goodsSaleNums := []models.GoodsSaleNum{}
	models.DB.Find(&goodsSaleNums)
	X_str := []string{}
	// 打印查询结果
	for _, goodsSaleNum := range goodsSaleNums {
		var goods models.Goods
		models.DB.First(&goods, goodsSaleNum.GoodsId)
		//fmt.Printf("GoodsId: %d, Title: %s\n", goodsSaleNum.GoodsId, goods.Title)
		X_str = append(X_str, goods.Title)
	}
	// Put data into instance
	items := make([]opts.PieData, 0)
	for i := 0; i < 10; i++ {
		items = append(items, opts.PieData{
			Name:  X_str[i],
			Value: goodsSaleNums[i].SaledNum})
	}
	pie.SetSeriesOptions()
	pie.AddSeries("Monthly revenue",
		items).
		SetSeriesOptions(
			charts.WithPieChartOpts(
				opts.PieChart{
					Radius: 200,
				},
			),
			charts.WithLabelOpts(
				opts.Label{
					Show:      true,
					Formatter: "{b}: {c}",
				},
			),
		)
	f, _ := os.Create("views/admin/datashow/pie.html")
	_ = pie.Render(f)
	c.TplName = "admin/datashow/pie.html"

}
