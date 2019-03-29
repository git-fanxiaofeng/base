package io.raycom.components.mail;



import io.raycom.core.collection.RData;

import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dm.model.v20151123.SingleSendMailRequest;
import com.aliyuncs.dm.model.v20151123.SingleSendMailResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;

public class AliyunMailSender{
	
	public void sendMailHtmlAsync() {   
	    // 如果是除杭州region外的其它region（如新加坡、澳洲Region），需要将下面的"cn-hangzhou"替换为"ap-southeast-1"、或"ap-southeast-2"。
	    IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAIcKfLyin2hhhS", "wBZBLKp2JuBJYgKlX7ugy1NkrWn1b5");
	    IAcsClient client = new DefaultAcsClient(profile);
	    SingleSendMailRequest request = new SingleSendMailRequest();
	    try {
	    	request.setActionName("SingleSendMail");
	        request.setAccountName("usc@keshiku.cn");
	        request.setFromAlias("");
	        request.setAddressType(1);
	        request.setTagName("notice");
	        request.setReplyToAddress(true);
	        request.setToAddress("");
	        request.setSubject("邮件主题");
	        request.setHtmlBody("邮件正文");
	        SingleSendMailResponse httpResponse = client.getAcsResponse(request);
	    } catch (ClientException e) {
	        e.printStackTrace();
	    }     
    }
	
	public void sendMailHtmlAsync(RData rdata) {   
	    // 如果是除杭州region外的其它region（如新加坡、澳洲Region），需要将下面的"cn-hangzhou"替换为"ap-southeast-1"、或"ap-southeast-2"。
	    IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAIcKfLyin2hhhS", "wBZBLKp2JuBJYgKlX7ugy1NkrWn1b5");
	    IAcsClient client = new DefaultAcsClient(profile);
	    SingleSendMailRequest request = new SingleSendMailRequest();
	    try {
	    	request.setActionName("SingleSendMail");
	        request.setAccountName("usc@keshiku.cn");
	        request.setFromAlias("");
	        request.setAddressType(1);
	        request.setTagName("notice");
	        request.setReplyToAddress(true);
	        request.setToAddress(rdata.getString("toAddress"));
	        request.setSubject(rdata.getString("subject"));
	        request.setHtmlBody(rdata.getString("htmlBody"));
	        SingleSendMailResponse httpResponse = client.getAcsResponse(request);
	    } catch (ClientException e) {
	        e.printStackTrace();
	    }     
    }
}

