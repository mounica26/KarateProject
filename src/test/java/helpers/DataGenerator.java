package helpers;

import com.github.javafaker.Faker;

public class  DataGenerator {

    public static String randomEmail()

    {

    Faker faker = new Faker();

    String email = faker.name().username() + "@test.com";
    return email;

    }

    public static String randomname()
    {
        Faker faker = new Faker();
        String name = faker.name().username();
        return name;
    }
    
}
