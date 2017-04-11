package dendy.rpms.converters;

import dendy.rpms.utils.DateFormatEnum;
import org.springframework.core.convert.converter.Converter;
import org.springframework.util.StringUtils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 字符串转日期类型转换器
 *
 * @author dendy
 * @date 2013-6-18
 */
public class StringToDateConverter implements Converter<String, Date> {

    private String dateFormatPattern = DateFormatEnum.YYYY_MM_DD_HH_MM.getValue();

    public StringToDateConverter() {
    }

    @Override
    public Date convert(String source) {
        if (!StringUtils.hasLength(source)) {
            return null;
        }
        if (source.indexOf(":") < 0)
            dateFormatPattern = DateFormatEnum.YYYY_MM_DD.getValue();

        DateFormat df = new SimpleDateFormat(dateFormatPattern);
        try {
            return df.parse(source);
        } catch (ParseException e) {
            throw new IllegalArgumentException(String.format("类型转换失败，需要格式%s，但格式是[%s]", dateFormatPattern, source));
        }
    }

}
