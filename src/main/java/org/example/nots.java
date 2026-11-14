package org.example;

public class nots {

    /* 1. Downlode dependencies use MVN reposetory

    IOC container = Beans // objects
    every ioc container is Bean but every bean is not ioc container

    Spring handales object using two methods
    1. Annotation Base
    2. XML Configration based

    //creating object of class student
        Student s1=new Student();

        //in java one is special class jiska name hi class hota hai
        //this class hold karti hai metaData of other class ki
        Class<Student> c1 = Studen.class;  //Class   C1 store metaData of Student class


        C1 Store
        1.class name
        2.fields
        3.Constructors
        4.Method  etc.

        @component --> tells Spring to manage the class
        @Configuration --> to tell configuration class
        @ComponentScan --> scan the all Component present in the Project
        @Autowired-->

        Type of dependency injection
        1.constructor injection
        2.field injection
        3.setter injection


        Spring framework mai IOC containers ko ham Applicationcontext bolte hai



         */

    class Student {// class

        private int age;
        private String name;

        //Constructor
        public Student() {

        }

        //class methode
        public void getAttedance() {

        }

        public void name() {

        }
    }
}

