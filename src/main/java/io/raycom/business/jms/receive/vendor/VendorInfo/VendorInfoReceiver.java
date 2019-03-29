package io.raycom.business.jms.receive.vendor.VendorInfo;

import io.raycom.business.task.vendor.vendorInfo.VendorInfoTask;
import io.raycom.context.event.listener.RaycomEventPublisher;
import io.raycom.components.jms.listener.RaycomMessageListenerContainer;
import io.raycom.core.collection.RData;
import io.raycom.system.event.ErrorLogEvent;

import javax.jms.JMSException;
import javax.jms.TextMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 供应商信息接收端
 * @author fxf
 *
 */
@Component
public class VendorInfoReceiver extends RaycomMessageListenerContainer {

	@Value("${mq.vendorInfoToUHQ.dest}")
	private String destinationName;
	
	@Autowired
	public VendorInfoTask vendorInfoTask;
	
	@Override
	public void messageHandle(TextMessage message){
		String msg="";
	    try {
	    	msg=message.getText();
			vendorInfoTask.vendorMsgReceive(msg);
		} catch (JMSException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
			RData rdata=new RData();
			rdata.set("title","供应商信息接收");
			rdata.set("logType","mqReceive");
			rdata.set("mqMsg",msg);
			rdata.set("mqProcessLocation","VendorInfoReceiver.messageHandle");
			rdata.set("exceptionMsg",e.getMessage());
			rdata.set("topic","供应商信息接收错误日志");
			rdata.set("currentUser", "system");
			RaycomEventPublisher.publishEvent(new ErrorLogEvent(rdata));
			throw e;
		}
	}
	public String getDestinationName() {
		return destinationName;
	}
}

