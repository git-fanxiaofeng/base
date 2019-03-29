package io.raycom.modules.sys.chart;

import io.raycom.core.collection.RData;
import io.raycom.web.persistence.annotation.MyBatisDao;

import java.util.ArrayList;
import java.util.List;

/**
 * 图表化数据查询Dao
 * @author GuoJianmin
 * @date 2016年8月19日
 * @version 1.0.0
 */
@MyBatisDao
public interface ChartDao {

	public ArrayList<RData> queryCertValidForLine(RData rData);
	public ArrayList<RData> queryCertValidForPie(RData rData);
	public String queryUnprocessed(RData rData);
	public RData checkNoticeNumber(RData rdata);
	public ArrayList<RData> noticeTitle(RData rdata);
	public List<RData> queryVendorCertificate(RData rData);
}

