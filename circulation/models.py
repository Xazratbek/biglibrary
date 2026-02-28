from django.db import models
from catalog.models import Book
from django.contrib.auth.models import User

class ReservationChoices(models.TextChoices):
    PENDING = "pending"
    ACTIVE = "active"
    CANCELLED = "cancelled"
    EXPIRED = "expired"

class StatusChoices(models.TextChoices):
    AVAILABLE = "available"
    RESERVED = "reserved"
    BORROWED = "borrowed"
    LOST = "lost"

class Branch(models.Model):
    name = models.CharField(max_length=250,verbose_name="Filial nomi",db_index=True)
    city = models.CharField(max_length=155,verbose_name="Shaxar")
    address = models.TextField(verbose_name="To'liq adress",blank=True,null=True)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ["name"]
        verbose_name = "Filial"
        verbose_name_plural = "Filiallar"

class BookCopy(models.Model):
    book = models.ForeignKey(Book,on_delete=models.CASCADE,related_name="nusxalar")
    branch = models.ForeignKey(Branch,on_delete=models.CASCADE,related_name="filialkitoblar")
    inventory_code = models.CharField(max_length=300,unique=True,verbose_name="Inventar raqami")
    status = models.CharField(max_length=30,choices=StatusChoices.choices,default=StatusChoices.AVAILABLE)
    added_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.book.title

    class Meta:
        verbose_name = "Kitob nusxasi"
        verbose_name_plural = "Kitob nusxalari"

class Borrow(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE,related_name="borrowed_book",verbose_name="Foydalanuvchi")
    copy = models.ForeignKey(BookCopy,on_delete=models.CASCADE,related_name="kitob")
    borrowed_at = models.DateTimeField(verbose_name="Olingan vaqt",auto_now_add=True)
    due_at = models.DateTimeField(verbose_name="Muddati")
    returned_at = models.DateTimeField(verbose_name="Qaytarilgan vaqt",blank=True)
    fine_amount = models.DecimalField(verbose_name="Jarima miqdori",blank=True,decimal_places=2,max_digits=12)

    def __str__(self):
        return f"Qarzdor: {self.user.get_full_name()} | Kitob: {self.copy}"

    class Meta:
        verbose_name = "Qarz"
        verbose_name_plural = "Qarzlar"

class Reservation(models.Model):
    user = models.ForeignKey(User,on_delete=models.CASCADE,related_name="reservation")
    book = models.ForeignKey(Book,on_delete=models.CASCADE,related_name="reservation")
    branch = models.ForeignKey(Branch,on_delete=models.CASCADE,related_name="reservation")
    status = models.CharField(max_length=20,verbose_name="Xolati",choices=ReservationChoices.choices,default=ReservationChoices.PENDING)
    created_at = models.DateTimeField(auto_now_add=True,verbose_name="Yaratilgan vaqt")
    expires_at = models.DateTimeField(verbose_name="Tugaydigan vaqti")

    def __str__(self):
        return f"Reservation to: {self.user} | Kitob: {self.book} | status: {self.status}"

    class Meta:
        verbose_name = "Bron"
        verbose_name_plural = "Bronlar"
