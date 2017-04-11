package dendy.rpms.utils;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializerProvider;

import java.io.IOException;
import java.text.SimpleDateFormat;

/**
 * 自定义JSON转换器
 *
 * @author chengjianlong
 */
public class CustomObjectMapper extends ObjectMapper {
    public CustomObjectMapper() {
        super();
        // null 值转为""
        getSerializerProvider().setNullValueSerializer(new JsonSerializer<Object>() {
            @Override
            public void serialize(Object value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
                jgen.writeString("");
            }
        });

        // 转换前台日期格式
        SimpleDateFormat formatter = new SimpleDateFormat(DateFormatEnum.YYYY_MM_DD_HH_MM_SS.getValue());
        this.setDateFormat(formatter);
    }
}