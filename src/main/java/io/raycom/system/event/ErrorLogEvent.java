package io.raycom.system.event;

import io.raycom.context.event.RayComEvent;

/**
 * 代理商变更申请事件
 * 使用 ：RaycomEventPublisher.publishEvent(new ErrorLogEvent(rdata));
 * @author GJM 
 * @date 2017年10月26日
 * @version 1.0.0
 */
public class ErrorLogEvent extends RayComEvent {

	public ErrorLogEvent(Object source) {  
        super(source);  
    }  
	public ErrorLogEvent() { }  
}
