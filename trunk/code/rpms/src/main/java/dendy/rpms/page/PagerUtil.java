package dendy.rpms.page;


/**
 * 分页工具
 *
 * @author Dendy
 * @since 2014-2-18 12:56:40
 */
public class PagerUtil {

    /**
     * 不关心总记录数
     *
     * @param pageNumber
     * @param pageSize
     * @return
     */
    public static int getPageStart(int pageNumber, int pageSize) {
        return (pageNumber - 1) * pageSize;
    }

    /**
     * 计算分页获取数据时游标的起始位置
     *
     * @param totalCount 所有记录总和
     * @param pageNumber 页码,从1开始
     * @return
     */
    public static int getPageStart(int totalCount, int pageNumber, int pageSize) {
        int start = (pageNumber - 1) * pageSize;
        if (start >= totalCount) {
            start = 0;
        }

        return start;
    }

    /**
     * 计算总页数
     *
     * @param records  总记录数
     * @param pageSize 每页显示数量
     * @return
     */
    public static int getPageCount(int records, int pageSize) {
        if (pageSize == 0) {
            return 0;
        }
        int div = records / pageSize;
        return (records % pageSize == 0) ? div : div + 1;
    }
}
