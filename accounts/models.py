from django.db import models
from django.contrib.auth.models import User
from django.core.validators import RegexValidator

class MemberShipChoices(models.TextChoices):
    BASIC = "basic", "Basic"
    PRO = "pro", "Pro"


class LibraryCard(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE,related_name="librarycard")
    phone = models.CharField(max_length=13,validators=[RegexValidator(regex = r"^\+?998(?:90|91|93|94|88|97|95|99|77|33|98)\d{7}$")],unique=True,error_messages={
    "invalid": "Faqat O'zbekiston aloqa operatorlari qo'llab-quvvatlanadi.",
    "unique": "Bu telefon raqam allaqachon ro'yxatdan o'tgan."}
)
    membership_level = models.CharField(max_length=5,choices=MemberShipChoices.choices,default=MemberShipChoices.BASIC)
    balance = models.DecimalField(verbose_name="Balans",decimal_places=2,max_digits=12)
    created_at = models.DateTimeField(verbose_name="Yaratilgan vaqt",auto_now_add=True)
    updated_at = models.DateTimeField(verbose_name="Yangilangan vaqt",auto_now=True)

    def __str__(self):
        return self.user.get_full_name()

    class Meta:
        verbose_name = "Kutubxonachi"
        verbose_name_plural = "Kutubxonachilar"