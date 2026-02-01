package com.influ.notification;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface NotificationMapper {

    @Mapping(target = "read", expression = "java(notification.isRead())")
    NotificationResponse toResponse(Notification notification);
}
