package io.raycom.modules.vendor.util;

import java.util.ArrayList;

import io.raycom.core.collection.RData;

/**
 * 供应商信息查看
 * @author wx
 * @date 2016-04-14
 * @version 1.0.0  
 */
public class VendorUtil{
	
	public static ArrayList<RData> getCertUnitData(ArrayList<RData> certUnitTemp) {
		RData certUnitContent = new RData();
		for (RData cert : certUnitTemp) {
			RData certUnit = getCertUnitCardByContent(certUnitContent,cert);
			RData certDetail =(RData)certUnit.get("certDetail");
			
			//将资质数据放入各自的资质管理单元卡中，以其资质大类作为分组标志，代理商的企业信息单独一个分类
			if("companyCert".equals(cert.getString("certParentCategory"))&&
					!certUnit.getString("certUnitName").equals(cert.getString("certificateName"))) {
				
					ArrayList<RData> certPost = (ArrayList<RData>)certDetail.get("agentCompanyCert");
					processAgentCompanyUnit(certPost,cert);
			}else{
				ArrayList<RData> certPost = new ArrayList<RData>();
				certPost = (ArrayList<RData>)certDetail.get(cert.getString("certParentCategory"));
				certPost.add(cert);
			}
		}
		
		ArrayList<RData> cert = new ArrayList<RData>();
		
		for (Object key : certUnitContent.keySet()) {
			cert.add((RData)certUnitContent.get(key));
		}
		return cert;
	}
	
	/**
	 * 代理商的资质信息以tab方式显示，需要做代理商分别存储数据
	 * @return
	 */
	private static void processAgentCompanyUnit(ArrayList<RData> certPost,RData cert) {
		
		RData agentCert = new RData();
		for (RData agentCertTmp : certPost) {
			if(agentCertTmp.get("certUnitId").equals(cert.getString("certificateName")))
				agentCert = agentCertTmp;
		}
		
		if(agentCert.isEmpty()) {
			agentCert.set("certUnitId", cert.getString("certificateName"));
			agentCert.set("certUnitName", cert.getString("certificateName"));
			agentCert.set("agentCompanyCert", new ArrayList<RData>());
			certPost.add(agentCert);
		}
		
		ArrayList<RData> agentCertList = (ArrayList<RData>)agentCert.get("agentCompanyCert");
		agentCertList.add(cert);
	}
	
	
	/**
	 * 获取资质管理单元卡中的资质信息，如果不存在则事先进行初始化
	 * 之后返回资质管理单元
	 * @return
	 */
	private static RData getCertUnitCardByContent(RData certUnitContent,RData cert) {
		String certUnitMstId = cert.getString("certUnitMstId");
		RData certUnit = (RData)certUnitContent.get(certUnitMstId);
		if(certUnit==null) {
			certUnit = new RData();
			RData certCard = new RData();
			certUnit.set("certUnitId", cert.getString("certUnitMstId"));
			certUnit.set("certUnitName", cert.getString("certUnitMstName"));
			certUnit.set("certDetail",certCard);
			
			certCard.set("companyCert", new ArrayList<RData>());
			certCard.set("authorizeCert", new ArrayList<RData>());
			certCard.set("productCert", new ArrayList<RData>());
			certCard.set("agentCompanyCert", new ArrayList<RData>());
			
			certUnitContent.set(certUnitMstId, certUnit);
		}	
		return certUnit;
	}
	
}
