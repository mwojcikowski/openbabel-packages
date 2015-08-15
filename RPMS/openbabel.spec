#
# spec file for package openbabel
#

Name:           openbabel
Version:        2.3.90_2015.08~1
Release:        0
Summary:        Open Babel - The Open Source Chemistry Toolbox
License:        GPL-2.0
Group:          Development/Libraries/C and C++
Url:            https://github.com/openbabel/openbabel
Source:         %{name}-%{version}.tar.gz
BuildRequires:  cmake
BuildRequires:  gcc-c++
#BuildRequires:  eigen3-devel
BuildRequires:  pkgconfig
BuildRequires:  python-devel
BuildRequires:  swig >= 2.0.0
BuildRequires:  zlib-devel
BuildRequires:  pkgconfig(cairo)
BuildRequires:  pkgconfig(libxml-2.0)
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%description
Open Babel build from Git

%package -n libopenbabel4
Summary:        Open Babel - The Open Source Chemistry Toolbox
Group:          Development/Libraries/C and C++

%description -n libopenbabel4
Open Babel build from Git

%package -n libopenbabel-devel
Summary:        Open Babel - The Open Source Chemistry Toolbox
Group:          Development/Libraries/C and C++
Requires:       libopenbabel4 = %{version}
Requires:       zlib-devel

%description -n libopenbabel-devel
Open Babel build from Git

%package -n python-openbabel
Summary:        Open Babel - The Open Source Chemistry Toolbox
Group:          Productivity/Scientific/Chemistry
#%py_requires

%description -n python-openbabel
Open Babel build from Git

%prep
%setup -q

%build
%define libsuffix ""
%if "%{_lib}" == "lib64"
%define libsuffix 64
%endif
cmake -DCMAKE_INSTALL_PREFIX=%{_prefix} -DLIB_SUFFIX=%libsuffix -DPYTHON_BINDINGS=ON -DCMAKE_SKIP_INSTALL_RPATH=ON -DRUN_SWIG=ON
make %{?_smp_mflags}

%install
make DESTDIR=%{buildroot} install

%post -n libopenbabel4 -p /sbin/ldconfig

%postun -n libopenbabel4 -p /sbin/ldconfig

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%{_libdir}/openbabel
%{_bindir}/roundtrip
%{_datadir}/openbabel
%{_mandir}/man1/*
%{_bindir}/ob*
%{_bindir}/babel
%{_libdir}/cmake/openbabel2/

%files -n libopenbabel4
%defattr(-,root,root,-)
%{_libdir}/*.so.*

%files -n libopenbabel-devel
%defattr(-,root,root,-)
%{_libdir}/pkgconfig/openbabel-2.0.pc
%dir %{_includedir}/inchi
%{_includedir}/inchi/inchi_api.h
%dir %{_includedir}/openbabel-2.0
%{_includedir}/openbabel-2.0/openbabel/
%{_libdir}/*.so

%files -n python-openbabel
%defattr(-,root,root,-)
%{python_sitearch}*

%changelog
