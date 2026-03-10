from django.urls import path
from . import views

urlpatterns = [
    path("ping/",views.ping,name="ping"),
    path("library_card/<int:librarycard_id>/",views.get_library_card_by_id,name="get_lb_id"),
    path("search/",views.search,name="search"),
    path("create/",views.create_ok,name="create_ok"),
    path("check_request_method/",views.check_request_method,name="check_r"),
    path("post_list/",views.post_list,name="post_list"),
    path("post_detail/<int:post_id>/",views.post_detail,name="post_detail"),
    path("salomlash/",views.salomlash,name="salomlash"),
    path("users/<int:user_id>/",views.get_users,name="get_users",)
]
