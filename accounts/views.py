from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from .models import LibraryCard
from http import HTTPStatus
from django.views.decorators.csrf import ensure_csrf_cookie
import json

def ping(request):
    return JsonResponse({"status": "ok"})

def get_library_card_by_id(request, librarycard_id):
    lb = LibraryCard.objects.filter(id=librarycard_id)
    return JsonResponse({
        "status": "ok", "librarycard_id": librarycard_id, "lb_user_fname": lb[0].user.username, "lb_phone": lb[0].phone,"lb_membership_level": lb[0].membership_level,"lb_balance": lb[0].balance
    })

def search(request):
    q = request.GET.get("q", "")
    return JsonResponse({"query": q})

def create_ok(request):
    return JsonResponse({
        "created": True
    }, status=HTTPStatus.CREATED)

@ensure_csrf_cookie
def check_request_method(request):
    if request.method == "GET":
        return JsonResponse({"method": "GET"})
    if request.method == "POST":
        return JsonResponse({"method": "POST"})
    return JsonResponse({"error": "Method not allowed"}, status=405)

def create_post(request):
    payload = json.loads(request.body or "{}")
    return JsonResponse({"title": payload.get("title")})

POSTS = [{"id": 1, "title": "Hello"}, {"id": 2, "title": "World"}]

def post_list(request):
    return JsonResponse({"items": POSTS})

def post_detail(request, post_id):
    post = next((p for p in POSTS if p["id"] == post_id), None)
    return JsonResponse({"item": post})

def salomlash(request):
    return JsonResponse({"message": "Hi"})

def get_users(request,user_id):
    users = LibraryCard.objects.filter(id=user_id)
    return JsonResponse({"users": users[0].user.username,"user_id": user_id})