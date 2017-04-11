package dendy.rpms.utils;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

/**
 * <p>Created by Dendy on 2014/9/6.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class FileHelper extends FileUtils {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(FileHelper.class);

    //~ Instance fields ================================================================================================

    //~ Methods ========================================================================================================

    public static void deleteFiles(File[] files) {
        for (int i = 0; i < files.length; i++) {
            File file = files[i];
            if (file.exists() && file.isFile())
                file.delete();
        }
    }
}
