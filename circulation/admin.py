from django.contrib import admin
from .models import *

@admin.register(Branch)
class BranchAdmin(admin.ModelAdmin):
    list_display = ["name","city","address"]
    list_filter = ["city"]

@admin.register(BookCopy)
class BookCopyAdmin(admin.ModelAdmin):
    list_display = ["book","branch","inventory_code","status","added_at"]
    list_filter = ["status"]
    search_fields = ["book","branch","inventory_code"]

@admin.register(Borrow)
class BorrowAdmin(admin.ModelAdmin):
    list_display = ["user","copy","borrowed_at","due_at","returned_at","fine_amount"]
    list_filter = ["returned_at"]

@admin.register(Reservation)
class ReservationAdmin(admin.ModelAdmin):
    list_display = ["user","book","branch","status","created_at","expires_at"]
