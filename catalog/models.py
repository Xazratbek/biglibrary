from django.db import models

class CountryChoices(models.TextChoices):
    UZ = "uz", "Uzbekistan"
    RU = "ru", "Russia"

class LanguageChoices(models.TextChoices):
    UZ = "uz", "O'zbek tili"
    RU = "ru", "Rus tili"
    ENG = "eng", "Ingliz tili"

class Author(models.Model):
    full_name = models.CharField(max_length=100,verbose_name="F.I.O",help_text="To'liq F.I.Oni kiriting")
    country = models.CharField(verbose_name="Davlat",choices=CountryChoices.choices,default=CountryChoices.UZ,db_index=True)
    birth_year = models.DateField(verbose_name="Tug'ilgan yil",blank=True,null=True)

    def __str__(self):
        return self.full_name

    class Meta:
        verbose_name = "Muallif"
        verbose_name_plural = "Mualliflar"

class Genre(models.Model):
    name = models.CharField(max_length=100,verbose_name="Nomi",unique=True)
    slug = models.SlugField(max_length=255,verbose_name="Slug maydoni",help_text="URL uchun, masalan: my-post-title",unique=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Janr"
        verbose_name_plural = "Janrlar"

class Tag(models.Model):
    name = models.CharField(max_length=155,verbose_name="Teg nomi",unique=True)
    slug = models.SlugField(max_length=255,verbose_name="Slug maydoni",help_text="URL uchun, masalan: my-post-title",unique=True)

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Teg"
        verbose_name_plural = "Teglar"

class Book(models.Model):
    title = models.CharField(max_length=150,verbose_name="Kitob nomi")
    description = models.TextField(verbose_name="Kitob haqida batafsil")
    author = models.ForeignKey(Author,on_delete=models.CASCADE,related_name="kitoblar",verbose_name="Muallif")
    genres = models.ManyToManyField(Genre,related_name="kitoblar",verbose_name="Janr",)
    tags = models.ManyToManyField(Tag,related_name="kitoblar",verbose_name="Teg")
    published_year = models.IntegerField(verbose_name="Ishlab chiqarilgan sana")
    isbn = models.CharField(max_length=255,verbose_name="Xalqaro standart kitob raqami",unique=True)
    language = models.CharField(max_length=10,choices=LanguageChoices.choices,default=LanguageChoices.UZ,verbose_name="Til")
    price = models.DecimalField(verbose_name="Kitob narxi",decimal_places=2,max_digits=12)
    created_at = models.DateTimeField(verbose_name="Yaratilgan vaqt",auto_now_add=True)
    updated_at = models.DateTimeField(verbose_name="Yangilangan vaqt",auto_now=True)

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = "Kitob"
        verbose_name_plural = "Kitoblar"