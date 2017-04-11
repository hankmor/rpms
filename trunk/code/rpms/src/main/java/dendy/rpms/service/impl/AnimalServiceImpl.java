package dendy.rpms.service.impl;

import dendy.rpms.constant.SystemConst;
import dendy.rpms.dao.AnimalDao;
import dendy.rpms.dao.HouseDao;
import dendy.rpms.domain.AnimalEntity;
import dendy.rpms.domain.AttaEntity;
import dendy.rpms.entity.*;
import dendy.rpms.page.Pager;
import dendy.rpms.page.PagerUtil;
import dendy.rpms.query.AnimalQuery;
import dendy.rpms.service.*;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.FileHelper;
import dendy.rpms.utils.FileNameHelper;
import dendy.rpms.utils.UserUtil;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

/**
 * 圈舍服务实现
 *
 * @author Dendy
 * @since 14-2-21
 */
@Service
public class AnimalServiceImpl implements IAnimalService {
	private static final Logger LOG = LoggerFactory.getLogger(AnimalServiceImpl.class);
	@Autowired
	private AnimalDao redPandaDao;
	@Autowired
	private HouseDao houseDao;
	@Autowired
	private IHouseTransferService houseTransferService;
	@Autowired
	private IGenotypeService genotypeService;
	@Autowired
	private IAttaService attaService;
	@Autowired
	private IPrimerService primerService;

	private static final String PHOTO_SAVE_PATH = SystemConst.FILE_SAVE_PATH + "/animal-photos/";

	@Override
	public Animal get(Long id) {
		Assert.notNull(id);
		return redPandaDao.getWithType(id);
	}

	@Override
	public Animal getByMicrochipCode(String no) {
		Assert.hasLength(no);
		return redPandaDao.getByMicrochipCode(no);
	}

	@Override
	public Animal getByNo(String no) {
		Assert.hasLength(no);
		return redPandaDao.getByNo(no);
	}

	@Override
	@Transactional
	public void update(Animal animal) {
		Assert.notNull(animal);
		LOG.info("update animal info.");
		Animal src = redPandaDao.get(animal.getId());
		Animal father = animal.getAnimalByFather();
		if (father != null && father.getId() == null)
			src.setAnimalByFather(null);
		else src.setAnimalByFather(animal.getAnimalByFather());
		Animal mother = animal.getAnimalByMother();
		if (mother != null && mother.getId() == null)
			src.setAnimalByMother(null);
		else src.setAnimalByMother(animal.getAnimalByMother());
		House house = animal.getHouse();
		if (house != null && house.getId() == null)
			src.setHouse(null);
		else src.setHouse(animal.getHouse());
		src.setTatooCode(animal.getTatooCode());
		src.setStudbookCode(animal.getStudbookCode());
		src.setEarCode(animal.getEarCode());
		src.setLipCode(animal.getLipCode());
		src.setSex(animal.getSex());
		src.setAge(animal.getAge());
		src.setBirthDate(animal.getBirthDate());
		src.setChipTime(animal.getChipTime());
		src.setAnimalType(animal.getAnimalType());
		src.setRemark(animal.getRemark());

		src.setUserByUpdateUser(UserUtil.getUserModel());
		src.setUpdateTime(new Date());
		redPandaDao.update(src);
	}

	@Override
	@Transactional
	public void add(Animal animal) {
		Assert.notNull(animal);
		LOG.info("add animal.");
		Animal father = animal.getAnimalByFather();
		if (father != null && father.getId() == null)
			animal.setAnimalByFather(null);
		Animal mother = animal.getAnimalByMother();
		if (mother != null && mother.getId() == null)
			animal.setAnimalByMother(null);
		House house = animal.getHouse();
		if (house != null && house.getId() == null)
			animal.setHouse(null);
		// 默认为在养状态
		animal.setStatus(SystemConst.ANIMAL_STATUS_FEEDING);
		animal.setCreateTime(new Date());
		animal.setUserByCreateUser(UserUtil.getUserModel());
		redPandaDao.save(animal);
		// 记录来源信息，并记录到圈舍转移库中.
		if (StringUtils.hasLength(animal.getComeFrom()) || animal.getHouse() != null) {
			HouseTransfer houseTransfer = new HouseTransfer();
			houseTransfer.setAnimal(animal);
			houseTransfer.setHouseByDestHouse(animal.getHouse());
			if (StringUtils.hasLength(animal.getComeFrom()))
				houseTransfer.setTransType(SystemConst.TRANS_IN_FROM_OTHER_ZOO);
			else
				houseTransfer.setTransType(SystemConst.TRANS_IN_FROM_LOCAL_ZOO);
			houseTransfer.setZoo(animal.getComeFrom());
			houseTransfer.setTransTime(new Date());
			houseTransfer.setCreateTime(new Date());
			houseTransfer.setUserByCreateUser(UserUtil.getUserModel());
			houseTransferService.add(houseTransfer);
		}
	}

	@Override
	@Transactional
	public void delete(String ids) {
		Assert.hasLength(ids);
		LOG.info("delete animals with id in " + ids);
		String[] idArray = ids.split(",");
		List<Animal> animals = new LinkedList<>();
		for (int i = 0; i < idArray.length; i++) {
			Long id = Long.parseLong(idArray[i]);
			Animal redPanda = redPandaDao.get(Animal.class, id);
			// 逻辑删除，非物理删除
//            redPanda.setStatus(SystemConst.ANIMAL_STATUS_DELETE);
//            redPandaDao.update(redPanda);
			// 修改为物理删除 2014-8-29 15:48:05 dendy.
			animals.add(redPanda);
		}
		redPandaDao.deleteAll(animals);
	}

	@Override
	public Pager<AnimalEntity> page(AnimalQuery animalQuery) {
		Assert.notNull(animalQuery, "animalQuery object must not be null!");
		int beginNum = PagerUtil.getPageStart(animalQuery.getPage(), animalQuery.getRows());
		return redPandaDao.findPagerData(animalQuery.projectionList(), animalQuery.getDomainClass(),
				animalQuery.getDetachedCriteria(), beginNum, animalQuery.getRows());
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRES_NEW)
	public void mark(String ids, Animal animal) {
		Assert.hasLength(ids);
		Assert.notNull(animal);
		String[] idArray = ids.split(",");
		for (int i = 0; i < idArray.length; i++) {
			Long id = Long.parseLong(idArray[i]);
			Animal redPanda = redPandaDao.get(Animal.class, id);
			redPanda.setStatus(animal.getStatus());
			redPanda.setHouse(null);
			redPanda.setUpdateTime(new Date());
			redPanda.setUserByUpdateUser(UserUtil.getUserModel());
			if (StringUtils.hasLength(animal.getRemark()))
				redPanda.setRemark(animal.getRemark());
			redPandaDao.update(redPanda);
		}
	}

	@Override
	public void addGenotypes(String animalNo, String primerNo, String codeA, String codeB) {
		Assert.hasLength(animalNo);
		Assert.hasLength(primerNo);
		Animal animal = redPandaDao.getByNoWithGenotypes(animalNo);
		updateAnimalGenotypes(primerNo, codeA, codeB, animal);
	}

	private void updateAnimalGenotypes(String primerNo, String codeA, String codeB, Animal animal) {
		Set<AnimalGenotype> ags = animal.getAnimalGenotypes();
		Primer primer = primerService.getByNo(primerNo);
		Genotype genotypeA = null;
		Genotype genotypeB = null;
		if (StringUtils.hasLength(codeA)) {
			genotypeA = genotypeService.getByNo(codeA, primerNo);
			// 不存在，先添加
			if (genotypeA == null)
				genotypeA = addGenoType(codeA, primer);
		}
		if (StringUtils.hasLength(codeB)) {
			genotypeB = genotypeService.getByNo(codeB, primerNo);
			// 不存在，先添加
			if (genotypeB == null)
				genotypeB = addGenoType(codeB, primer);
		}
		if (genotypeA == null && genotypeB == null)
			return;
		AnimalGenotype ag = new AnimalGenotype();
		ag.setAnimal(animal);
		ag.setGenotypeByGenotypeA(genotypeA);
		ag.setGenotypeByGenotypeB(genotypeB);
		ag.setPrimer(primer);
		ag.setCreateTime(new Date());
		AnimalGenotypeId agId = new AnimalGenotypeId();
		agId.setAnimal(animal.getId());
		if (genotypeA != null)
			agId.setGenotypeA(genotypeA.getId());
		if (genotypeB != null)
			agId.setGenotypeB(genotypeB.getId());
		agId.setPrimer(primer.getId());
		ag.setId(agId);
		ags.add(ag);
		animal.setAnimalGenotypes(ags);
		redPandaDao.update(animal);
	}

	@Override
	@Transactional
	public void addGenotypes(Long id, String primerNo, String codeA, String codeB) {
		Assert.notNull(id);
		Assert.hasLength(primerNo);
		Animal animal = redPandaDao.getWithGenotypes(id);
		updateAnimalGenotypes(primerNo, codeA, codeB, animal);
	}

	private Genotype addGenoType(String code, Primer primer) {
		Genotype genotype = new Genotype();
		genotype.setCodeA(Integer.valueOf(code));
		genotype.setCreateTime(new Date());
		genotype.setPrimer(primer);
		genotypeService.add(genotype);
		return genotype;
	}

	@Override
	@Transactional
	public void deleteGenotypes(Long id, String ids) {
		Assert.notNull(id);
		Assert.hasLength(ids);
		Animal animal = redPandaDao.getWithGenotypes(id);
		String[] idArray = ids.split(",");
		Set<AnimalGenotype> genotypes = animal.getAnimalGenotypes();
		for (int i = 0; i < idArray.length; i++) {
			String[] data = idArray[i].split(":");
			String codeA = data[0];
			String codeB = data[1];
			String primerNo = data[2];
			Genotype a = null, b = null;
			if (StringUtils.hasLength(codeA))
				a = genotypeService.getByNo(codeA, primerNo);
			if (StringUtils.hasLength(codeB))
				b = genotypeService.getByNo(codeB, primerNo);
			Primer primer = primerService.getByNo(primerNo);
			AnimalGenotypeId animalGenotypeId = new AnimalGenotypeId();
			if (a != null)
				animalGenotypeId.setGenotypeA(a.getId());
			if (b != null)
				animalGenotypeId.setGenotypeB(b.getId());
			animalGenotypeId.setPrimer(primer.getId());
			animalGenotypeId.setAnimal(animal.getId());
			AnimalGenotype ag = new AnimalGenotype();
			ag.setId(animalGenotypeId);
			genotypes.remove(ag);
		}
		redPandaDao.update(animal);
	}

	@Override
	@Transactional
	public void uploadPhoto(Long animalId, Atta atta, MultipartFile photo) throws IOException {
		Assert.notNull(animalId);
		Assert.notNull(atta);
		Assert.notNull(photo);
		File savePath = new File(PHOTO_SAVE_PATH + animalId);
		if (!savePath.exists() || !savePath.isDirectory()) savePath.mkdirs();

		String srcFileName = photo.getOriginalFilename();
		InputStream is = photo.getInputStream();
		String ext = FileNameHelper.getExtension(srcFileName);
		String savedFileName = FileNameHelper.timestampFileName(ext);

		Atta dest = new Atta();
		dest.setName(StringUtils.hasLength(atta.getName()) ? atta.getName() + "." + ext : srcFileName);
		dest.setFileName(savedFileName);
		dest.setDescription(atta.getDescription());
		dest.setRemark(atta.getRemark());
		dest.setSize((long) is.available());
		dest.setPath("/animal-photos/" + animalId + "/");
		dest.setType(SystemConst.ATTA_TYPE_PIC);

		User createUser = UserUtil.getUserModel();
		dest.setUserByUploadUser(createUser);
		dest.setUploadTime(new Date());

		FileUtils.copyInputStreamToFile(is, new File(PHOTO_SAVE_PATH + animalId + "/" + savedFileName));

		attaService.add(dest);

		Animal animal = redPandaDao.getWithAttas(animalId);
		Set<Atta> attas = animal.getAttas();
		attas.add(dest);
		redPandaDao.update(animal);
	}

	@Override
	@Transactional
	public void deletePhotos(Long animalId, String ids) {
		Assert.notNull(animalId);
		Assert.hasLength(ids);
		String[] idArray = ids.split(",");

		File[] files = new File[idArray.length];
		// Set<Atta> attas = new LinkedHashSet<>();
		for (int i = 0; i < idArray.length; i++) {
			Long id = Long.parseLong(idArray[i]);
			Atta atta = attaService.get(id);
			String savedPath = SystemConst.FILE_SAVE_PATH + atta.getPath() + atta.getFileName();
			files[i] = new File(savedPath);
			// attas.add(atta);
		}

		// 不需要这么做，因为数据库已经级联删除
		// Animal animal = redPandaDao.getWithAttas(animalId);
		// Set<Atta> srcAttas = animal.getAttas();
		// srcAttas.removeAll(attas);
		// redPandaDao.update(animal);

		attaService.delete(ids);
		FileHelper.deleteFiles(files);
	}

	@Override
	public List<AttaEntity> listAttas(Long animalId) {
		Assert.notNull(animalId);
		return redPandaDao.listAttas(animalId);
	}

	@Override
	public Animal getWithGenotypes(Long id) {
		Assert.notNull(id);
		return redPandaDao.getWithGenotypes(id);
	}

	@Override
	public AnimalGenotype getGenotype(Long animalId, Long primerId) {
		Assert.notNull(animalId);
		Assert.notNull(primerId);
		return redPandaDao.getGenotype(animalId, primerId);
	}
}
