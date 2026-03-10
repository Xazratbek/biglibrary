# from django.shortcuts import render
# from .models import Book
# from django.http import HttpResponse
# # Create your views here.


# def test(request):
#     d = []
#     books = Book.objects.all()
#     for book in books:
#         reviews = book.reviews.all()
#         if len(reviews) > 0:

#             avg = sum([int(i.rating) for i in reviews]) // len(reviews)
#             print(avg)
#             d.append(f"<h1>{book.title} -- {avg}....\n</h1>")
#     print(d)
#     return HttpResponse(d)
