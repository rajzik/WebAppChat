

from django.conf.urls import url, include
from django.contrib import admin
from django.views.decorators.csrf import csrf_exempt
from graphene_django.views import GraphQLView


from schema import schema

urlpatterns = [
    url(r'^graphiql', GraphQLView.as_view(schema=schema, graphiql=True)),
    url(r'^graphql', csrf_exempt(GraphQLView.as_view(schema=schema)))
]
