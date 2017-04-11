package dendy.rpms.entity;

// Generated 2014-10-26 13:48:43 by Hibernate Tools 3.6.0

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Atta generated by hbm2java
 */
@Entity
@Table(name = "atta", catalog = "rpms")
public class Atta implements java.io.Serializable {

	private Long					id;
	private User					userByUpdateUser;
	private User					userByUploadUser;
	private String					name;
	private String					fileName;
	private String					path;
	private Long					size;
	private Byte					type;
	private String					description;
	private Date					uploadTime;
	private Date					updateTime;
	private String					remark;
	private Set<Anatomy>			anatomies			= new HashSet<Anatomy>(0);
	private Set<ExaminationAtta>	examinationAttas	= new HashSet<ExaminationAtta>(0);
	private Set<Animal>				animals				= new HashSet<Animal>(0);
	private Set<Feed>				feeds				= new HashSet<Feed>(0);
	private Set<Animal>				animals_1			= new HashSet<Animal>(0);

	public Atta() {
	}

	public Atta(User userByUpdateUser, User userByUploadUser, String name, String fileName, String path, Long size, Byte type,
			String description, Date uploadTime, Date updateTime, String remark, Set<Anatomy> anatomies,
			Set<ExaminationAtta> examinationAttas, Set<Animal> animals, Set<Feed> feeds, Set<Animal> animals_1) {
		this.userByUpdateUser = userByUpdateUser;
		this.userByUploadUser = userByUploadUser;
		this.name = name;
		this.fileName = fileName;
		this.path = path;
		this.size = size;
		this.type = type;
		this.description = description;
		this.uploadTime = uploadTime;
		this.updateTime = updateTime;
		this.remark = remark;
		this.anatomies = anatomies;
		this.examinationAttas = examinationAttas;
		this.animals = animals;
		this.feeds = feeds;
		this.animals_1 = animals_1;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "ID", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "UPDATE_USER")
	public User getUserByUpdateUser() {
		return this.userByUpdateUser;
	}

	public void setUserByUpdateUser(User userByUpdateUser) {
		this.userByUpdateUser = userByUpdateUser;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "UPLOAD_USER")
	public User getUserByUploadUser() {
		return this.userByUploadUser;
	}

	public void setUserByUploadUser(User userByUploadUser) {
		this.userByUploadUser = userByUploadUser;
	}

	@Column(name = "NAME", length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "FILE_NAME", length = 100)
	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Column(name = "PATH", length = 300)
	public String getPath() {
		return this.path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	@Column(name = "SIZE")
	public Long getSize() {
		return this.size;
	}

	public void setSize(Long size) {
		this.size = size;
	}

	@Column(name = "TYPE")
	public Byte getType() {
		return this.type;
	}

	public void setType(Byte type) {
		this.type = type;
	}

	@Column(name = "DESCRIPTION", length = 500)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "UPLOAD_TIME", length = 19)
	public Date getUploadTime() {
		return this.uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "UPDATE_TIME", length = 19)
	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "REMARK", length = 300)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "anatomy_atta", catalog = "rpms", joinColumns = { @JoinColumn(name = "ATTA", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "ANATOMY", nullable = false, updatable = false) })
	public Set<Anatomy> getAnatomies() {
		return this.anatomies;
	}

	public void setAnatomies(Set<Anatomy> anatomies) {
		this.anatomies = anatomies;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "atta")
	public Set<ExaminationAtta> getExaminationAttas() {
		return this.examinationAttas;
	}

	public void setExaminationAttas(Set<ExaminationAtta> examinationAttas) {
		this.examinationAttas = examinationAttas;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "animal_atta", catalog = "rpms", joinColumns = { @JoinColumn(name = "ATTA", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "ANIMAL", nullable = false, updatable = false) })
	public Set<Animal> getAnimals() {
		return this.animals;
	}

	public void setAnimals(Set<Animal> animals) {
		this.animals = animals;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "feed_atta", catalog = "rpms", joinColumns = { @JoinColumn(name = "ATTA", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "FEED", nullable = false, updatable = false) })
	public Set<Feed> getFeeds() {
		return this.feeds;
	}

	public void setFeeds(Set<Feed> feeds) {
		this.feeds = feeds;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "atta")
	public Set<Animal> getAnimals_1() {
		return this.animals_1;
	}

	public void setAnimals_1(Set<Animal> animals_1) {
		this.animals_1 = animals_1;
	}

}
