package io.raycom.modules.sys.chart;

import io.raycom.core.collection.RData;
import io.raycom.web.service.BaseService;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 图表化数据查询Service
 * @author GuoJianmin
 * @date 2016年8月19日
 * @version 1.0.0
 */
@Service
@Transactional(readOnly = true)
public class ChartService extends BaseService {

	@Autowired
	private ChartDao chartDao;
	
	public ArrayList<RData> queryCertValidForLine(RData rData){
		return chartDao.queryCertValidForLine( rData);
	}
	
	public ArrayList<RData> queryCertValidForPie(RData rData){
		return chartDao.queryCertValidForPie( rData);
	}
	
	public String queryUnprocessed(RData rData){
		return chartDao.queryUnprocessed(rData);
	}
	
	public String checkNoticeNumber(RData rdata){
		 return chartDao.checkNoticeNumber(rdata).getString("noticeNum");
	}
	public ArrayList<RData> noticeTitle(RData rdata){
		return chartDao.noticeTitle(rdata);
	}
	
	public List<RData> queryVendorCertificate(RData rData) {
		return chartDao.queryVendorCertificate(rData);
	}
}

