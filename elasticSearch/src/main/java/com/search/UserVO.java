package com.search; // 패키지 확인: com.search로 설정

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.LocalDate;
import java.util.List;

//@JsonIgnoreProperties(ignoreUnknown = true)
public class UserVO {
    @JsonProperty("name")
    private String name;

    @JsonProperty("age")
    private int age;

    @JsonProperty("email")
    private String email;

    @JsonProperty("department")
    private String department;

    @JsonProperty("salary")
    private int salary;

    @JsonProperty("join_date") // JSON의 join_date와 매핑
    private LocalDate joinDate;

    @JsonProperty("city")
    private String city;

    @JsonProperty("skills")
    private List<String> skills;

    @JsonProperty("active")
    private boolean active;

    // 기본 생성자 (Jackson 역직렬화에 필요)
    public UserVO() {
    }

    // Getter와 Setter (기존 코드 유지)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public LocalDate getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(LocalDate joinDate) {
        this.joinDate = joinDate;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public List<String> getSkills() {
        return skills;
    }

    public void setSkills(List<String> skills) {
        this.skills = skills;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return "UserVO [name=" + name + ", age=" + age + ", email=" + email + ", department=" + department + ", salary="
                + salary + ", joinDate=" + joinDate + ", city=" + city + ", skills=" + skills + ", active=" + active + "]";
    }
}