To run ipython notebook:

docker run -d -p 80:8888 -v /notebooks:/notebooks -e "PASSWORD=daas" -e "USE_HTTP=1" uninett-daas/notebook-spark
