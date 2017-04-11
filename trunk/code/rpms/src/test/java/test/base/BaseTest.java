package test.base;

import junit.framework.TestCase;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.client.RestTemplate;

import java.lang.reflect.Field;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations =
        {
                "classpath:spring/applicationContext.xml",
                "classpath:spring/springMVC.xml",
                "classpath:spring/applicationContext-security.xml"
        })
public class BaseTest extends TestCase {
    protected RestTemplate restTemplate = new RestTemplate();

    protected void p(Object s) {
        if (null != s) {
            Class<?> clz = s.getClass();
            Field[] fields = clz.getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true);
                try {
                    System.out.println(field.getName() + ":" + field.get(s));
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                }
            }
        } else {
            System.out.println("Object is null!");
        }
    }

    void p(String str) {
        System.out.println(str);
    }
}
