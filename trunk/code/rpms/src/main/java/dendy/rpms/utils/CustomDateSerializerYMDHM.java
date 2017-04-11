package dendy.rpms.utils;

import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * java日期对象经过Jackson库转换成JSON日期格式化自定义类
 * 
 */
public class CustomDateSerializerYMDHM extends JsonSerializer<Date> {

	public void serialize(Date value, JsonGenerator jgen, SerializerProvider provider) throws IOException, JsonProcessingException {
		SimpleDateFormat formatter = new SimpleDateFormat(DateFormatEnum.YYYY_MM_DD_HH_MM.getValue());
		String formattedDate = formatter.format(value);
		jgen.writeString(formattedDate);
	}
}
