package io.raycom.business.support.email.base;



import io.raycom.context.event.listener.RaycomEventPublisher;
import io.raycom.core.collection.RData;
import io.raycom.system.event.MailEvent;


/**
 * 阿里云邮件发送
 */
public class SendEmail {
	
	/**
	 * 供应商企业信息审批结果通知
	 * rdata
	 * toAddress 邮件地址
	 * htmlBody 内容
	 * subject 主题
	 */
	public void sendVendorPublicEmail(RData rdata){
        RData r=new RData();
        r.set("subject", "供应商基础信息审批通知");
        String htmlBody="";
        if("Y".equals(rdata.getString("status"))){
        	htmlBody=rdata.getString("vendorChName")+"供应商，您的企业基础信息已经审核通过！";
        }else{
        	htmlBody=rdata.getString("vendorChName")+"供应商，您的企业基础信息审核没有通过，请参照审核意见，修改后重新提交审核！";
        }
        r.set("htmlBody", htmlBody);
        r.set("toAddress", rdata.getString("email"));
		//sendEmail(r);
	}
	
	/**
	 * 供应商产品信息审批结果通知
	 * rdata
	 * toAddress 邮件地址
	 * htmlBody 内容
	 * subject 主题
	 */
	public void sendMaterialPublicEmail(RData rdata){
        RData r=new RData();
        r.set("subject", "产品基础信息审批通知");
        String htmlBody="";
        if("Y".equals(rdata.getString("status"))){
        	htmlBody=rdata.getString("vendorChName")+"供应商，您的产品："+rdata.getString("materialChName")+"  规格："+rdata.getString("spec")+"  型号："+rdata.getString("model")+" 已经审核通过！";
        }else{
        	htmlBody=rdata.getString("vendorChName")+"供应商，您的产品："+rdata.getString("materialChName")+"  规格："+rdata.getString("spec")+"  型号："+rdata.getString("model")+" 审核没有通过，请参照审核意见，修改后重新提交审核！";
        }
        r.set("htmlBody", htmlBody);
        r.set("toAddress", rdata.getString("email"));
		//sendEmail(r);
	}
	
	/**
	 * 供应商企业入院信息审批结果通知
	 * rdata
	 * toAddress 邮件地址
	 * htmlBody 内容
	 * subject 主题
	 */
	public void sendVendorHospitalizedEmail(RData rdata){
        RData r=new RData();
        r.set("subject", "供应商入院信息审批通知");
        String htmlBody="";
        if("04".equals(rdata.getString("status"))){
        	htmlBody=rdata.getString("vendorChName")+"供应商，您的企业入院信息已经审核通过！";
        }else{
        	htmlBody=rdata.getString("vendorChName")+"供应商，您的企业入院信息审核没有通过，请参照审核意见，修改后重新提交审核！";
        }
        r.set("htmlBody", htmlBody);
        r.set("toAddress", rdata.getString("email"));
		sendEmail(r);
	}
	
	/**
	 * 供应商产品入院信息审批结果通知
	 * rdata
	 * toAddress 邮件地址
	 * htmlBody 内容
	 * subject 主题
	 */
	public void sendMaterialHospitalizedEmail(RData rdata){
        RData r=new RData();
        r.set("subject", "产品入院信息审批通知");
        String htmlBody="";
        if("02".equals(rdata.getString("status"))){
        	htmlBody=rdata.getString("vendorChName")+"供应商，您的产品："+rdata.getString("materialChName")+"  规格："+rdata.getString("spec")+"  型号："+rdata.getString("model")+" 医院已经审核通过！";
        }else{
        	htmlBody=rdata.getString("vendorChName")+"供应商，您的产品："+rdata.getString("materialChName")+"  规格："+rdata.getString("spec")+"  型号："+rdata.getString("model")+" 医院审核没有通过，请参照审核意见，修改后重新提交审核！";
        }
        r.set("htmlBody", htmlBody);
        r.set("toAddress", rdata.getString("email"));
		sendEmail(r);
	}
	

	
	//邮件发送
	public void sendEmail(RData rdata){
		RaycomEventPublisher.publishEvent(new MailEvent(rdata));
	}
	
}
