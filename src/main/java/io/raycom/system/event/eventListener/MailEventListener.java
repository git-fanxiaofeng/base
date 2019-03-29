package io.raycom.system.event.eventListener;

import io.raycom.context.event.RayComEvent;
import io.raycom.context.event.listener.IRayComEventListener;
import io.raycom.core.collection.RData;
import io.raycom.system.event.MailEvent;
import io.raycom.components.mail.AliyunMailSender;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class MailEventListener implements IRayComEventListener{
	
	@Override
	public void onRayComEvent(RayComEvent event) {
		//发送邮件
        RData r=(RData) event.getSource();
        AliyunMailSender AliyunMailSender=new AliyunMailSender();
        AliyunMailSender.sendMailHtmlAsync(r);
	}

	@Override
	public List<String> getEventClasses() {
		List<String> className = new ArrayList<String>();
		className.add(MailEvent.class.getName());
		return className;
	}

}
