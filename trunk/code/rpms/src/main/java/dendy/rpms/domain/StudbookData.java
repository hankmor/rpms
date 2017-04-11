package dendy.rpms.domain;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>Created by Dendy on 2014/9/21.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class StudbookData {
    //~ Static fields/initializers =====================================================================================

    //~ Instance fields ================================================================================================

    private String microchipCode;
    private String studbookCode;
    private String sex;
    private String photoPath;
    private String name;
    // 存放子孙或者祖辈数据
    private List<StudbookData> children = new ArrayList<>();

    //~ Methods ========================================================================================================


    public String getMicrochipCode() {
        return microchipCode;
    }

    public void setMicrochipCode(String microchipCode) {
        this.microchipCode = microchipCode;
    }

    public String getStudbookCode() {
        return studbookCode;
    }

    public void setStudbookCode(String studbookCode) {
        this.studbookCode = studbookCode;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getPhotoPath() {
        return photoPath;
    }

    public void setPhotoPath(String photoPath) {
        this.photoPath = photoPath;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<StudbookData> getChildren() {
        return children;
    }

    public void setChildren(List<StudbookData> children) {
        this.children = children;
    }
}
