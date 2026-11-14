package org.example;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;  // Use AnnotationConfi  Start Spring Container

public class Main {
    public static void main(String []args) {
        ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);

        orderService order = context.getBean(orderService.class);
        order.placeOrder();

    }
}

