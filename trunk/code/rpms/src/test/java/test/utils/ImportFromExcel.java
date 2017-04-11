//package test.utils;
//
//import com.banyouinfotech.msoffice.excel.MSExcelHelper;
//import dendy.rpms.service.IAnimalService;
//import dendy.rpms.service.IGenotypeService;
//import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.Row;
//import org.apache.poi.ss.usermodel.Sheet;
//import org.apache.poi.ss.usermodel.Workbook;
//import org.junit.Test;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.util.StringUtils;
//import test.base.BaseTest;
//
//import java.io.IOException;
//import java.util.LinkedList;
//import java.util.List;
//
///**
// * <p>Created by sun on 2014/11/20.
// *
// * @author sun
// * @version 0.1
// * @since 0.1
// */
//public class ImportFromExcel extends BaseTest {
//	//~ Static fields/initializers =====================================================================================
//	private static final Logger LOG = LoggerFactory.getLogger(ImportFromExcel.class);
//
//	//~ Instance fields ================================================================================================
//	private static String filePath = "D:\\workspace\\idea-workspace\\rpms\\trunk\\doc\\docs\\2014-11-14张亮提供\\redpanda.xlsx";
//	private static String genotypeSheetName = "小熊猫基因型";
//
//	@Autowired
//	private IGenotypeService genotypeService;
//	@Autowired
//	private IAnimalService animalService;
//
//	//~ Methods ========================================================================================================
//
//	@Test
//	public void testImport() throws IOException, InvalidFormatException {
//		int animalNoIndex = 0;
//		Workbook wb = MSExcelHelper.openExcel(filePath);
//		Sheet sheet = MSExcelHelper.getSheet(wb, genotypeSheetName);
//		List<String> primerNoList = new LinkedList<>();
//		String animalNo = "";
//		Integer codeA = null;
//		Integer codeB = null;
//		String curPrimerNo = "";
//		String primerNo = "";
//		String tmp = "";
//		for (Row row : sheet) {
//			for (Cell cell : row) {
//				int rowIndex = row.getRowNum();
//				int colIndex = cell.getColumnIndex();
//				// 获取引物编号
//				if (rowIndex == 0) {
//					primerNo = cell.getRichStringCellValue().getString().trim();
//					primerNoList.add(primerNo);
//					continue;
//				}
//				// 动物编号
//				if (colIndex == animalNoIndex) {
//					Integer no = (int) cell.getNumericCellValue();
//					animalNo = "000".substring(0, "000".length() - no.toString().length()).concat(no.toString());
//					continue;
//				}
//				int cellType = cell.getCellType();
//				Integer genotype = null;
//				if (cellType == Cell.CELL_TYPE_NUMERIC) {
//					genotype = (int) cell.getNumericCellValue();
//				} else {
//					tmp = cell.getStringCellValue();
//					if (StringUtils.hasLength(tmp)) {
//						genotype = Integer.parseInt(tmp);
//					} else
//						genotype = null;
//				}
//
//				if (genotype != null && genotype == 0)
//					genotype = null;
//
//				tmp = primerNoList.get(colIndex).toLowerCase();
//				boolean save = false;
//				if (tmp.endsWith("a")) {
//					codeA = genotype;
//					codeB = null; // 清空codeB
//				} else if (tmp.endsWith("b")) {
//					codeB = genotype;
//					save = true;
//				} else {
//					throw new RuntimeException("illegal primer no found.");
//				}
//				if (save) {
//					curPrimerNo = primerNoList.get(colIndex);
//					curPrimerNo = curPrimerNo.substring(0, curPrimerNo.length() - 1);
//					if (codeA != null || codeB != null) {
//						LOG.info("begin to save :" + animalNo + "." + curPrimerNo + ":" + codeA + " - " + codeB);
//						animalService.addGenotypes(animalNo, curPrimerNo,
//								codeA != null ? String.valueOf(codeA) : "",
//								codeB != null ? String.valueOf(codeB) : "");
//					}
//				}
//			}
//		}
////		LOG.info("primer no list is : {}", primerNoList);
//	}
//}
