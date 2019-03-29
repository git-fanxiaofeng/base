package io.raycom.modules.sys.chart;

import io.raycom.core.collection.RData;
import io.raycom.web.support.mvc.controller.BaseController;
import io.raycom.web.support.utils.user.UserUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 图表数据查询Controller
 * @author yangjiajie
 * @date 2016年10月20日
 * @version 1.0.0
 */
@Controller
@RequestMapping(value = "${adminPath}/chart")
public class ChartController extends BaseController {
	
	@Autowired
	private ChartService chartService;
	
	/**
	 * 进入图表化页面
	 * @return
	 */
	@RequestMapping(value={"list",""})
	public String approveList(Model model){
		System.out.println(rdata);
		model.addAttribute("number",chartService.queryUnprocessed(rdata));
		model.addAttribute("noticeNumber",chartService.checkNoticeNumber(rdata));
		model.addAttribute("noticeTitle",chartService.noticeTitle(rdata));
		model.addAttribute("certificateList", chartService.queryVendorCertificate(rdata));
		return "sys/chart/main";
	}
	
	/**
	 * 查询资质效期线形图所需数据
	 * @return 含有x轴、y轴数据的map集合
	 */
	@RequestMapping(value="certValidLine")
	@ResponseBody
	public Map<String, Object> queryCertValidForLine(){
		rdata.set("vendorId", UserUtils.getUser().getCompanyId());
		ArrayList<RData> rListLine=chartService.queryCertValidForLine(rdata);
		ArrayList<RData> rListPie=chartService.queryCertValidForPie(rdata);
		String xData[]= new String[rListLine.size()];
		String yData[]= new String[rListLine.size()];
		for(int i=0;i<rListLine.size();i++){
			xData[i]=rListLine.get(i).getString("certificateName");
			yData[i]=rListLine.get(i).getString("DAYS");
		}
		Map<String, Object> data= new HashMap<String, Object>();
		data.put("xData", xData);
		data.put("yData", yData);
		data.put("pie", rListPie);
		return data;
	}

}

