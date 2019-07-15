clean:
	-rm -rf docs/build
	-docker rmi `docker images -q --filter "dangling=true"`

update:
	wget --no-check-certificate -O docs/source/for_developers/services/auth.rst https://raw.githubusercontent.com/willnx/vlab_auth_service/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/onefs.rst https://raw.githubusercontent.com/willnx/vlab_onefs/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/gateway.rst https://raw.githubusercontent.com/willnx/vlab_gateway/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/ecs.rst https://raw.githubusercontent.com/willnx/vlab_ecs/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/vlan.rst https://raw.githubusercontent.com/willnx/vlab_vlan/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/esxi.rst https://raw.githubusercontent.com/willnx/vlab_esxi/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/claritynow.rst https://raw.githubusercontent.com/willnx/vlab_claritynow/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/icap.rst https://raw.githubusercontent.com/willnx/vlab_icap/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/centos.rst https://raw.githubusercontent.com/willnx/vlab_centos/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/winserver.rst https://raw.githubusercontent.com/willnx/vlab_winserver/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/windows.rst https://raw.githubusercontent.com/willnx/vlab_windows/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/cee.rst https://raw.githubusercontent.com/willnx/vlab_cee/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/insightiq.rst https://raw.githubusercontent.com/willnx/vlab_insightiq/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/proxy.rst https://raw.githubusercontent.com/willnx/vlab_proxy/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/router.rst https://raw.githubusercontent.com/willnx/vlab_router/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/esrs.rst https://raw.githubusercontent.com/willnx/vlab_esrs/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/inventory.rst https://raw.githubusercontent.com/willnx/vlab_inventory/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/power.rst https://raw.githubusercontent.com/willnx/vlab_power/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/ipam.rst https://raw.githubusercontent.com/willnx/vlab_ipam_api/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/snapshot.rst https://raw.githubusercontent.com/willnx/vlab_snapshot/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/cli.rst https://raw.githubusercontent.com/willnx/vlab_cli/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/recycler.rst https://raw.githubusercontent.com/willnx/vlab_recycler/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/dns.rst https://raw.githubusercontent.com/willnx/vlab_dns/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/ntp.rst https://raw.githubusercontent.com/willnx/vlab_ntp/master/README.rst
	wget --no-check-certificate -O docs/source/for_developers/services/links.rst https://raw.githubusercontent.com/willnx/vlab_links/master/README.rst

build: clean
	cd docs && ${MAKE} html

images: build
	docker build -t willnx/vlab-docs .

up: build
	docker run -it --rm -p 5000:80 -v `pwd`/docs/build/html:/usr/share/nginx/html willnx/vlab-docs
