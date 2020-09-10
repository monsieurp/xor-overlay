# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit check-reqs eutils mount-boot toolchain-funcs

DESCRIPTION="Linux kernel sources with some optional patches."
HOMEPAGE="https://kernel.org"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 arm arm64"

SLOT="${PV}"

RESTRICT="binchecks strip mirror"

IUSE="binary btrfs clang custom-cflags debug dmraid dtrace ec2 firmware hardened iscsi libressl luks lvm mcelog mdadm microcode multipath nbd nfs plymouth selinux sign-modules symlink systemd vanilla wireguard zfs"

BDEPEND="
    sys-devel/bc
    debug? ( dev-util/dwarves )
    virtual/libelf
"

DEPEND="
    binary? ( sys-kernel/dracut )
    btrfs? ( sys-fs/btrfs-progs )
    firmware? (
        sys-kernel/linux-firmware
    )
    luks? ( sys-fs/cryptsetup )
    lvm? ( sys-fs/lvm2 )
    mdadm? ( sys-fs/mdadm )
    mcelog? ( app-admin/mcelog )
    plymouth? (
        x11-libs/libdrm[libkms]
        sys-boot/plymouth[libkms,udev]
    )
    sign-modules? (
        || ( dev-libs/openssl
             dev-libs/libressl
        )
        sys-apps/kmod
    )
    systemd? ( sys-apps/systemd )
    wireguard? ( virtual/wireguard )
    zfs? ( sys-fs/zfs )
"

REQUIRED_USE="
    btrfs? ( binary )
    custom-cflags? ( binary )
    ec2? ( binary )
    libressl? ( binary )
    luks? ( binary )
    lvm? ( binary )
    mdadm? ( binary )
    microcode? ( binary )
    plymouth? ( binary )
    selinux? ( binary )
    sign-modules? ( binary )
    systemd? ( binary )
    wireguard? ( binary )
    zfs? ( binary )
"

# linux kernel upstream
KERNEL_VERSION="5.4.64"
KERNEL_ARCHIVE="linux-${KERNEL_VERSION}.tar.xz"
KERNEL_UPSTREAM="https://cdn.kernel.org/pub/linux/kernel/v5.x/${KERNEL_ARCHIVE}"
KERNEL_EXTRAVERSION="-cairn"

# temporarily use fedora kernel configs
KCONFIG_VERSION="5.4.21"
KCONFIG_HASH="2809b7faa6a8cb232cd825096c146b7bdc1e08ea"
KCONFIG_FILE="kernel-x86_64.config"
KCONFIG_UPSTREAM="https://src.fedoraproject.org/rpms/kernel/raw/${KCONFIG_HASH}/f/${KCONFIG_FILE}"

SRC_URI="
    ${KERNEL_UPSTREAM}
    ${KCONFIG_UPSTREAM}
"

S="$WORKDIR/linux-${KERNEL_VERSION}"

GENTOO_PATCHES_DIR="${WORKDIR}/gentoo-patches/"
GENTOO_PATCHES_RELEASE="5.4-63"
GENTOO_PATCHES_BASE="genpatches-${GENTOO_PATCHES_RELEASE}.base.tar.xz"
GENTOO_PATCHES_EXTRAS="genpatches-${GENTOO_PATCHES_RELEASE}.extras.tar.xz"
GENTOO_PATCHES_EXPERIMENTAL="genpatches-${GENTOO_PATCHES_RELEASE}.experimental.tar.xz"
GENTOO_PATCHES_UPSTREAM="
    https://dev.gentoo.org/~mpagano/genpatches/tarballs/${GENTOO_PATCHES_BASE}
    https://dev.gentoo.org/~mpagano/genpatches/tarballs/${GENTOO_PATCHES_EXTRAS}
    https://dev.gentoo.org/~mpagano/genpatches/tarballs/${GENTOO_PATCHES_EXPERIMENTAL}
"

SRC_URI+="
    ${GENTOO_PATCHES_UPSTREAM}
"

# Gentoo Linux 'genpatches' patch set
# 1510_fs-enable-link-security-restrctions-by-default.patch is already provided in debian patches
# 4567_distro-Gentoo-Kconfiig TODO?
GENTOO_PATCHES=(
    #1000_linux-5.4.1.patch
    #1001_linux-5.4.2.patch
    #1002_linux-5.4.3.patch
    #1003_linux-5.4.4.patch
    #1004_linux-5.4.5.patch
    #1005_linux-5.4.6.patch
    #1006_linux-5.4.7.patch
    #1007_linux-5.4.8.patch
    #1008_linux-5.4.9.patch
    #1009_linux-5.4.10.patch
    #1010_linux-5.4.11.patch
    #1011_linux-5.4.12.patch
    #1012_linux-5.4.13.patch
    #1013_linux-5.4.14.patch
    #1014_linux-5.4.15.patch
    #1015_linux-5.4.16.patch
    #1016_linux-5.4.17.patch
    #1017_linux-5.4.18.patch
    #1018_linux-5.4.19.patch
    #1019_linux-5.4.20.patch
    #1020_linux-5.4.21.patch
    #1021_linux-5.4.22.patch
    #1022_linux-5.4.23.patch
    #1023_linux-5.4.24.patch
    #1024_linux-5.4.25.patch
    #1025_linux-5.4.26.patch
    #1026_linux-5.4.27.patch
    #1027_linux-5.4.28.patch
    #1028_linux-5.4.29.patch
    #1029_linux-5.4.30.patch
    #1030_linux-5.4.31.patch
    #1031_linux-5.4.32.patch
    #1032_linux-5.4.33.patch
    #1033_linux-5.4.34.patch
    #1034_linux-5.4.35.patch
    #1035_linux-5.4.36.patch
    #1036_linux-5.4.37.patch
    #1037_linux-5.4.38.patch
    #1038_linux-5.4.39.patch
    #1039_linux-5.4.40.patch
    #1040_linux-5.4.41.patch
    #1041_linux-5.4.42.patch
    #1042_linux-5.4.43.patch
    #1043_linux-5.4.44.patch
    #1044_linux-5.4.45.patch
    #1045_linux-5.4.46.patch
    #1046_linux-5.4.47.patch
    #1047_linux-5.4.48.patch
    #1048_linux-5.4.49.patch
    #1049_linux-5.4.50.patch
    #1050_linux-5.4.51.patch
    #1051_linux-5.4.52.patch
    #1052_linux-5.4.53.patch
    #1053_linux-5.4.54.patch
    #1054_linux-5.4.55.patch
    #1055_linux-5.4.56.patch
    #1056_linux-5.4.57.patch
    #1057_linux-5.4.58.patch
    #1058_linux-5.4.59.patch
    #1059_linux-5.4.60.patch
    #1060_linux-5.4.61.patch
    1500_XATTR_USER_PREFIX.patch
#    1510_fs-enable-link-security-restrictions-by-default.patch
    2000_BT-Check-key-sizes-only-if-Secure-Simple-Pairing-enabled.patch
    2400_wireguard-backport-v5.4.54.patch
    2600_enable-key-swapping-for-apple-mac.patch
    2920_sign-file-patch-for-libressl.patch
    4567_distro-Gentoo-Kconfig.patch
#    5011_enable-cpu-optimizations-for-gcc8.patch
#    5012_enable-cpu-optimizations-for-gcc91.patch
    5013_enable-cpu-optimizations-for-gcc10.patch
)

# TODO: manage HARDENED_PATCHES and GENTOO_PATCHES can be managed in a git repository and packed into tar balls per version.

HARDENED_PATCHES_DIR="${FILESDIR}/${KERNEL_VERSION}/hardened-patches/"

# 'linux-hardened' minimal patch set to compliment existing Kernel-Self-Protection-Project
# 0033-enable-protected_-symlinks-hardlinks-by-default.patch
# 0058-security-perf-Allow-further-restriction-of-perf_even.patch
# 0060-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch
# All of the above already provided by Debian patches.
HARDENED_PATCHES=(
    0001-make-DEFAULT_MMAP_MIN_ADDR-match-LSM_MMAP_MIN_ADDR.patch
    0002-enable-HARDENED_USERCOPY-by-default.patch
    0003-disable-HARDENED_USERCOPY_FALLBACK-by-default.patch
    0004-enable-SECURITY_DMESG_RESTRICT-by-default.patch
    0005-set-kptr_restrict-2-by-default.patch
    0006-enable-DEBUG_LIST-by-default.patch
    0007-enable-BUG_ON_DATA_CORRUPTION-by-default.patch
    0008-enable-ARM64_SW_TTBR0_PAN-by-default.patch
    0009-arm64-enable-RANDOMIZE_BASE-by-default.patch
    0010-enable-SLAB_FREELIST_RANDOM-by-default.patch
    0011-enable-SLAB_FREELIST_HARDENED-by-default.patch
    0012-disable-SLAB_MERGE_DEFAULT-by-default.patch
    0013-enable-REFCOUNT_FULL-by-default.patch
    0014-enable-FORTIFY_SOURCE-by-default.patch
    0015-enable-PANIC_ON_OOPS-by-default.patch
    0016-stop-hiding-SLUB_DEBUG-behind-EXPERT.patch
    0017-stop-hiding-X86_16BIT-behind-EXPERT.patch
    0018-disable-X86_16BIT-by-default.patch
    0019-stop-hiding-MODIFY_LDT_SYSCALL-behind-EXPERT.patch
    0020-disable-MODIFY_LDT_SYSCALL-by-default.patch
    0021-set-LEGACY_VSYSCALL_NONE-by-default.patch
    0022-stop-hiding-AIO-behind-EXPERT.patch
    0023-disable-AIO-by-default.patch
    0024-remove-SYSVIPC-from-arm64-x86_64-defconfigs.patch
    0025-disable-DEVPORT-by-default.patch
    0026-disable-PROC_VMCORE-by-default.patch
    0027-disable-NFS_DEBUG-by-default.patch
    0028-enable-DEBUG_WX-by-default.patch
    0029-disable-LEGACY_PTYS-by-default.patch
    0030-disable-DEVMEM-by-default.patch
    0031-enable-IO_STRICT_DEVMEM-by-default.patch
    0032-disable-COMPAT_BRK-by-default.patch
    0033-use-maximum-supported-mmap-rnd-entropy-by-default.patch
    0034-enable-protected_-symlinks-hardlinks-by-default.patch
    0035-enable-SECURITY-by-default.patch
    0036-enable-SECURITY_YAMA-by-default.patch
    0037-enable-SECURITY_NETWORK-by-default.patch
    0038-enable-AUDIT-by-default.patch
    0039-enable-SECURITY_SELINUX-by-default.patch
    0040-enable-SYN_COOKIES-by-default.patch
    0041-add-__read_only-for-non-init-related-usage.patch
    0042-make-sysctl-constants-read-only.patch
    0043-mark-kernel_set_to_readonly-as-__ro_after_init.patch
    0044-mark-slub-runtime-configuration-as-__ro_after_init.patch
    0045-add-__ro_after_init-to-slab_nomerge-and-slab_state.patch
    0046-mark-kmem_cache-as-__ro_after_init.patch
    0047-mark-__supported_pte_mask-as-__ro_after_init.patch
    0048-mark-kobj_ns_type_register-as-only-used-for-init.patch
    0049-mark-open_softirq-as-only-used-for-init.patch
    0050-remove-unused-softirq_action-callback-parameter.patch
    0051-mark-softirq_vec-as-__ro_after_init.patch
    0052-mm-slab-trigger-BUG-if-requested-object-is-not-a-sla.patch
    0053-bug-on-kmem_cache_free-with-the-wrong-cache.patch
    0054-bug-on-PageSlab-PageCompound-in-ksize.patch
    0055-mm-add-support-for-verifying-page-sanitization.patch
    0056-slub-Extend-init_on_free-to-slab-caches-with-constru.patch
    0057-slub-Add-support-for-verifying-slab-sanitization.patch
    0058-slub-add-multi-purpose-random-canaries.patch
    0059-security-perf-Allow-further-restriction-of-perf_even.patch
    0060-enable-SECURITY_PERF_EVENTS_RESTRICT-by-default.patch
    0061-add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by.patch
    0062-add-kmalloc-krealloc-alloc_size-attributes.patch
    0063-add-vmalloc-alloc_size-attributes.patch
    0064-add-kvmalloc-alloc_size-attribute.patch
    0065-add-percpu-alloc_size-attributes.patch
    0066-add-alloc_pages_exact-alloc_size-attributes.patch
    0067-Add-the-extra_latent_entropy-kernel-parameter.patch
    0068-ata-avoid-null-pointer-dereference-on-bug.patch
    0069-sanity-check-for-negative-length-in-nla_memcpy.patch
    0070-add-page-destructor-sanity-check.patch
    0071-PaX-shadow-cr4-sanity-check-essentially-a-revert.patch
    0072-add-writable-function-pointer-detection.patch
    0073-support-overriding-early-audit-kernel-cmdline.patch
    0074-FORTIFY_SOURCE-intra-object-overflow-checking.patch
    0075-Revert-mm-revert-x86_64-and-arm64-ELF_ET_DYN_BASE-ba.patch
    0076-x86_64-move-vdso-to-mmap-region-from-stack-region.patch
    0077-x86-determine-stack-entropy-based-on-mmap-entropy.patch
    0078-arm64-determine-stack-entropy-based-on-mmap-entropy.patch
    0079-randomize-lower-bits-of-the-argument-block.patch
    0080-x86_64-match-arm64-brk-randomization-entropy.patch
    0081-support-randomizing-the-lower-bits-of-brk.patch
    0082-mm-randomize-lower-bits-of-brk.patch
    0083-x86-randomize-lower-bits-of-brk.patch
    0084-mm-guarantee-brk-gap-is-at-least-one-page.patch
    0085-x86-guarantee-brk-gap-is-at-least-one-page.patch
    0086-x86_64-bound-mmap-between-legacy-modern-bases.patch
    0087-restrict-device-timing-side-channels.patch
    0088-add-toggle-for-disabling-newly-added-USB-devices.patch
    0089-hard-wire-legacy-checkreqprot-option-to-0.patch
    0090-security-tty-Add-owner-user-namespace-to-tty_struct.patch
    0091-security-tty-make-TIOCSTI-ioctl-require-CAP_SYS_ADMI.patch
    0092-enable-SECURITY_TIOCSTI_RESTRICT-by-default.patch
    0093-disable-unprivileged-eBPF-access-by-default.patch
    0094-enable-BPF-JIT-hardening-by-default-if-available.patch
    0095-enable-protected_-fifos-regular-by-default.patch
    0096-Revert-mark-kernel_set_to_readonly-as-__ro_after_ini.patch
    0097-modpost-Add-CONFIG_DEBUG_WRITABLE_FUNCTION_POINTERS_.patch
    0098-mm-Fix-extra_latent_entropy.patch
    0099-add-CONFIG-for-unprivileged_userns_clone.patch
    0100-enable-INIT_ON_ALLOC_DEFAULT_ON-by-default.patch
    0101-enable-INIT_ON_FREE_DEFAULT_ON-by-default.patch
    0102-add-CONFIG-for-unprivileged_userfaultfd.patch
    0103-slub-Extend-init_on_alloc-to-slab-caches-with-constr.patch
    0104-net-tcp-add-option-to-disable-TCP-simultaneous-conne.patch
)

DTRACE_PATCHES_DIR="${FILESDIR}/${KERNEL_VERSION}/dtrace-patches"

DTRACE_PATCHES=(
    0001-ctf-generate-CTF-information-for-the-kernel.patch
    0002-kallsyms-introduce-new-proc-kallmodsyms-including-bu.patch
    0003-waitfd-new-syscall-implementing-waitpid-over-fds.patch
    0004-dtrace-core-and-x86.patch
    0005-dtrace-modular-components-and-x86-support.patch
    0006-dtrace-systrace-provider-core-components.patch
    0007-dtrace-systrace-provider.patch
    0008-dtrace-sdt-provider-core-components.patch
    0009-dtrace-sdt-provider-for-x86.patch
    0010-dtrace-profile-provider-and-test-probe-core-componen.patch
    0011-dtrace-profile-and-tick-providers-built-on-cyclics.patch
    0012-dtrace-USDT-and-pid-provider-core-and-x86-components.patch
    0013-dtrace-USDT-and-pid-providers.patch
    0014-dtrace-function-boundary-tracing-FBT-core-and-x86-co.patch
    0015-dtrace-fbt-provider-modular-components.patch
    0016-dtrace-arm-arm64-port.patch
    0017-dtrace-add-SDT-probes.patch
    0018-dtrace-add-rcu_irq_exit-and-rcu_nmi_exit_common-to-F.patch
    0019-dtrace-add-sample-script-for-building-DTrace-on-Fedo.patch
    0020-locking-publicize-mutex_owner-and-mutex_owned-again.patch
    0021-fixup-dtrace-function-boundary-tracing-FBT-core-and-.patch
    0022-fixup-dtrace-sdt-provider-core-components.patch
    0023-fixup-dtrace-modular-components-and-x86-support.patch
    0024-fixup-dtrace-add-SDT-probes.patch
)

eapply_hardened() {
    eapply "${HARDENED_PATCHES_DIR}/${1}"
}

eapply_gentoo() {
    eapply "${GENTOO_PATCHES_DIR}/${1}"
}

eapply_dtrace() {
    eapply "${DTRACE_PATCHES_DIR}/${1}"
}

get_certs_dir() {
    # find a certificate dir in /etc/kernel/certs/ that contains signing cert for modules.
    for subdir in $PF $P linux; do
        certdir=/etc/kernel/certs/$subdir
        if [ -d $certdir ]; then
            if [ ! -e $certdir/signing_key.pem ]; then
                eerror "$certdir exists but missing signing key; exiting."
                exit 1
            fi
            echo $certdir
            return
        fi
    done
}

pkg_pretend() {

    if use vanilla && use hardened; then
        die "vanilla and hardened USE flags are incompatible - Disable one of them."
    fi

    # Ensure we have enough disk space to compile
    if use binary ; then
        CHECKREQS_DISK_BUILD="5G"
        check-reqs_pkg_setup
    fi
}

pkg_setup() {
    export REAL_ARCH="$ARCH"
    unset ARCH; unset LDFLAGS #will interfere with Makefile if set
}

src_unpack() {

    # unpack the kernel sources to ${WORKDIR}
    unpack ${KERNEL_ARCHIVE} || die "failed to unpack kernel sources"

    # unpack genpatches... unfortunately they have no directory, so we need to create one
    mkdir "${WORKDIR}"/gentoo-patches && cd "${WORKDIR}"/gentoo-patches
    unpack ${GENTOO_PATCHES_BASE} && unpack ${GENTOO_PATCHES_EXTRAS} && unpack ${GENTOO_PATCHES_EXPERIMENTAL} || die "failed to unpack genpatches"
    cd "${WORKDIR}"

    # move kconfig to kernel sources directory
    cp "${DISTDIR}"/${KCONFIG_FILE} "${WORKDIR}"/linux-${KERNEL_VERSION}/.config
}

src_prepare() {

    debug-print-function ${FUNCNAME} "${@}"

    # only patch kernel sources if USE=-vanilla
    if ! use vanilla; then
        ### PATCHES ###

        # apply gentoo patches
        einfo "Applying Gentoo Linux patches ..."
        for my_patch in ${GENTOO_PATCHES[*]} ; do
            eapply_gentoo "${my_patch}"
        done

        # only apply these if USE=hardened as the patches will break proprietary userspace and some others.
        if use hardened; then
            # apply hardening patches
            einfo "Applying hardening patches ..."
            for my_patch in ${HARDENED_PATCHES[*]} ; do
                eapply_hardened "${my_patch}"
            done
        fi

        # optionally apply dtrace patches
        if use dtrace; then
            einfo "Applying DTrace patches ..."
            for my_patch in ${DTRACE_PATCHES[*]} ; do
                eapply_dtrace "${my_patch}"
            done
        fi

        # Cairn Linux patches are misc fix-ups

        einfo "Applying Cairn Linux patches ..."

        ## increase bluetooth polling patch
        eapply "${FILESDIR}"/${KERNEL_VERSION}/fix-bluetooth-polling.patch

        # Restore export_kernel_fpu_functions for zfs
        eapply "${FILESDIR}"/${KERNEL_VERSION}/export_kernel_fpu_functions.patch

        # append EXTRAVERSION to the kernel sources Makefile
        sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${KERNEL_EXTRAVERSION}:" Makefile || die "failed to append EXTRAVERSION to kernel Makefile"

        # todo: look at this, haven't seen it used in many cases.
        sed -i -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' Makefile || die "failed to fix-up INSTALL_PATH in kernel Makefile"
    fi

    ### TWEAK CONFIG ###

    # Do not configure Debian devs certificates
    echo 'CONFIG_SYSTEM_TRUSTED_KEYS=""' >> .config

    # enable IKCONFIG so that /proc/config.gz can be used for various checks
    # TODO: Maybe not a good idea for USE=hardened, look into this...
    echo "CONFIG_IKCONFIG=y" >> .config
    echo "CONFIG_IKCONFIG_PROC=y" >> .config

    if use custom-cflags; then
            MARCH="$(python -c "import portage; print(portage.settings[\"CFLAGS\"])" | sed 's/ /\n/g' | grep "march")"
            if [ -n "$MARCH" ]; then
                    sed -i -e 's/-mtune=generic/$MARCH/g' arch/x86/Makefile || die "Canna optimize this kernel anymore, captain!"
            fi
    fi

    # only enable debugging symbols etc if USE=debug...
    if use debug; then
        echo "CONFIG_DEBUG_INFO=y" >> .config
    else
        echo "CONFIG_DEBUG_INFO=n" >> .config
    fi

    if use dtrace; then
        echo "CONFIG_WAITFD=y" >> .config
    fi

    # these options should already be set, but are a hard dependency for ec2, so we ensure they are set if USE=ec2
    if use ec2; then
        echo "CONFIG_BLK_DEV_NVME=y" >> .config
        echo "CONFIG_XEN_BLKDEV_FRONTEND=m" >> .config
        echo "CONFIG_XEN_BLKDEV_BACKEND=m" >> .config
        echo "CONFIG_IXGBEVF=m" >> .config
    fi

    # hardening opts
    # TODO: document these
    if use hardened; then
        echo "CONFIG_AUDIT=y" >> .config
        echo "CONFIG_EXPERT=y" >> .config
        echo "CONFIG_SLUB_DEBUG=y" >> .config
        echo "CONFIG_SLAB_MERGE_DEFAULT=n" >> .config
        echo "CONFIG_SLAB_FREELIST_RANDOM=y" >> .config
        echo "CONFIG_SLAB_FREELIST_HARDENED=y" >> .config
        echo "CONFIG_SLAB_CANARY=y" >> .config
        echo "CONFIG_SHUFFLE_PAGE_ALLOCATOR=y" >> .config
        echo "CONFIG_RANDOMIZE_BASE=y" >> .config
        echo "CONFIG_RANDOMIZE_MEMORY=y" >> .config
        echo "CONFIG_HIBERNATION=n" >> .config
        echo "CONFIG_HARDENED_USERCOPY=y" >> .config
        echo "CONFIG_HARDENED_USERCOPY_FALLBACK=n" >> .config
        echo "CONFIG_FORTIFY_SOURCE=y" >> .config
        echo "CONFIG_STACKPROTECTOR=y" >> .config
        echo "CONFIG_STACKPROTECTOR_STRONG=y" >> .config
        echo "CONFIG_ARCH_MMAP_RND_BITS=32" >> .config
        echo "CONFIG_ARCH_MMAP_RND_COMPAT_BITS=16" >> .config
        echo "CONFIG_INIT_ON_FREE_DEFAULT_ON=y" >> .config
        echo "CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y" >> .config
        echo "CONFIG_SLAB_SANITIZE_VERIFY=y" >> .config
        echo "CONFIG_PAGE_SANITIZE_VERIFY=y" >> .config

        # gcc plugins
        if ! use clang; then
            echo "CONFIG_GCC_PLUGINS=y" >> .config
            echo "CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y" >> .config
            echo "CONFIG_GCC_PLUGIN_STRUCTLEAK=y" >> .config
            echo "CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=y" >> .config
            echo "CONFIG_GCC_PLUGIN_STACKLEAK=y" >> .config
            echo "CONFIG_STACKLEAK_TRACK_MIN_SIZE=100" >> .config
            echo "CONFIG_STACKLEAK_METRICS=n" >> .config
            echo "CONFIG_STACKLEAK_RUNTIME_DISABLE=n" >> .config
            echo "CONFIG_GCC_PLUGIN_RANDSTRUCT=y" >> .config
            echo "CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE=n" >> .config
        fi

        # main hardening options complete... anything after this point is a focus on disabling potential attack vectors
        # i.e legacy drivers, new complex code that isn't yet proven, or code that we really don't want in a hardened kernel.
        echo 'CONFIG_KEXEC=n' >> .config
        echo "CONFIG_KEXEC_FILE=n" >> .config
        echo 'CONFIG_KEXEC_SIG=n' >> .config
    fi

    # mcelog is deprecated, but there are still some valid use cases and requirements for it... so stick it behind a USE flag for optional kernel support.
    if use mcelog; then
        echo "CONFIG_X86_MCELOG_LEGACY=y" >> .config
    fi

    # sign kernel modules via
    if use sign-modules; then
        certs_dir=$(get_certs_dir)
        echo
        if [ -z "$certs_dir" ]; then
            eerror "No certs dir found in /etc/kernel/certs; aborting."
            die
        else
            einfo "Using certificate directory of $certs_dir for kernel module signing."
        fi
        echo
        # turn on options for signing modules.
        # first, remove existing configs and comments:
        echo 'CONFIG_MODULE_SIG=""' >> .config
        # now add our settings:
        echo 'CONFIG_MODULE_SIG=y' >> .config
        echo 'CONFIG_MODULE_SIG_FORCE=n' >> .config
        echo 'CONFIG_MODULE_SIG_ALL=n' >> .config
        # LibreSSL currently (2.9.0) does not have CMS support, so is limited to SHA1.
        # https://bugs.gentoo.org/706086
        # https://bugzilla.kernel.org/show_bug.cgi?id=202159
        if use libressl; then
            echo 'CONFIG_MODULE_SIG_HASH="sha1"' >> .config
        else
            echo 'CONFIG_MODULE_SIG_HASH="sha512"' >> .config
        fi
        echo 'CONFIG_MODULE_SIG_KEY="${certs_dir}/signing_key.pem"' >> .config
        echo 'CONFIG_SYSTEM_TRUSTED_KEYRING=y' >> .config
        echo 'CONFIG_SYSTEM_EXTRA_CERTIFICATE=y' >> .config
        echo 'CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE="4096"' >> .config

        # See above comment re: LibreSSL
        if use libressl; then
            echo "CONFIG_MODULE_SIG_SHA1=y" >> .config
        else
            echo "CONFIG_MODULE_SIG_SHA512=y" >> .config
        fi
        ewarn "This kernel will ALLOW non-signed modules to be loaded with a WARNING."
        ewarn "To enable strict enforcement, YOU MUST add module.sig_enforce=1 as a kernel boot"
        ewarn "parameter (to params in /etc/boot.conf, and re-run boot-update.)"
        echo
    fi

    # enable wireguard support within kernel
    if use wireguard; then
        echo 'CONFIG_WIREGUARD=m' >> .config
        # there are some other options, but I need to verify them first, so I'll start with this
    fi

    # get kconfig into good state
    yes "" | make oldconfig >/dev/null 2>&1 || die

    # punt kconfig to TEMPDIR for safe keeping
    cp .config "${T}"/.config || die

    # get the kernel sources into a good state
    make -s mrproper || die "make mrproper failed"

    # apply any user patches
    eapply_user
}

src_configure() {

    if use binary; then

        debug-print-function ${FUNCNAME} "${@}"

        tc-export_build_env
        MAKEARGS=(
            V=1

            HOSTCC="$(tc-getBUILD_CC)"
            HOSTCXX="$(tc-getBUILD_CXX)"
            HOSTCFLAGS="${BUILD_CFLAGS}"
            HOSTLDFLAGS="${BUILD_LDFLAGS}"

            CROSS_COMPILE=${CHOST}-
            AS="$(tc-getAS)"
            CC="$(tc-getCC)"
            LD="$(tc-getLD)"
            AR="$(tc-getAR)"
            NM="$(tc-getNM)"
            STRIP=":"
            OBJCOPY="$(tc-getOBJCOPY)"
            OBJDUMP="$(tc-getOBJDUMP)"

            # we need to pass it to override colliding Gentoo envvar
            ARCH=$(tc-arch-kernel)
        )

        mkdir -p "${WORKDIR}"/modprep || die
        cp "${T}"/.config "${WORKDIR}"/modprep/ || die
        emake O="${WORKDIR}"/modprep "${MAKEARGS[@]}" olddefconfig || die "kernel configure failed"
        emake O="${WORKDIR}"/modprep "${MAKEARGS[@]}" modules_prepare || die "modules_prepare failed"
        cp -pR "${WORKDIR}"/modprep "${WORKDIR}"/build || die
    fi
}

src_compile() {

    if use binary; then
        debug-print-function ${FUNCNAME} "${@}"

        emake O="${WORKDIR}"/build "${MAKEARGS[@]}" all || "kernel build failed"
    fi
}

src_install() {

    debug-print-function ${FUNCNAME} "${@}"

    # TODO: Change to SANDBOX_WRITE=".." for installkernel writes
    # Disable sandbox
    export SANDBOX_ON=0

    # copy sources into place:
    dodir /usr/src
    cp -a "${S}" "${D}"/usr/src/linux-${PV}${KERNEL_EXTRAVERSION} || die "failed to install kernel sources"
    cd "${D}"/usr/src/linux-${PV}${KERNEL_EXTRAVERSION}

    # prepare for real-world use and 3rd-party module building:
    make mrproper || die "failed to prepare kernel sources"

    # grab the kconfig we stored earlier...
    cp "${T}"/.config .config || die "failed to source kernel config from ${TEMPDIR}"

    # if we didn't use genkernel, we're done. The kernel source tree is left in
    # an unconfigured state - you can't compile 3rd-party modules against it yet.
    if use binary; then
        make prepare || die
        make scripts || die

        local targets=( modules_install )

        # ARM / ARM64 requires dtb
        if (use arm || use arm64); then
                targets+=( dtbs_install )
        fi

        emake O="${WORKDIR}"/build "${MAKEARGS[@]}" INSTALL_MOD_PATH="${ED}" INSTALL_PATH="${ED}/boot" "${targets[@]}"
        installkernel "${PV}${KERNEL_EXTRAVERSION}" "${WORKDIR}/build/arch/x86_64/boot/bzImage" "${WORKDIR}/build/System.map" "${EROOT}/boot"

        # module symlink fix-up:
        rm -rf "${D}"/lib/modules/${PV}${KERNEL_EXTRAVERSION}/source || die "failed to remove old kernel source symlink"
        rm -rf "${D}"/lib/modules/${PV}${KERNEL_EXTRAVERSION}/build || die "failed to remove old kernel build symlink"

        # Set-up module symlinks:
        ln -s /usr/src/linux-${PV}${KERNEL_EXTRAVERSION} "${ED}"/lib/modules/${PV}${KERNEL_EXTRAVERSION}/source || die "failed to create kernel source symlink"
        ln -s /usr/src/linux-${PV}${KERNEL_EXTRAVERSION} "${ED}"/lib/modules/${PV}${KERNEL_EXTRAVERSION}/build || die "failed to create kernel build symlink"

        # Fixes FL-14
        cp "${WORKDIR}/build/System.map" "${D}"/usr/src/linux-${PV}${KERNEL_EXTRAVERSION}/ || die "failed to install System.map"
        cp "${WORKDIR}/build/Module.symvers" "${D}"/usr/src/linux-${PV}${KERNEL_EXTRAVERSION}/ || die "failed to install Module.symvers"

        if use sign-modules; then
            for x in $(find "${ED}"/lib/modules -iname *.ko); do
                # $certs_dir defined previously in this function.
                ${WORKDIR}/build/scripts/sign-file sha512 $certs_dir/signing_key.pem $certs_dir/signing_key.x509 $x || die
            done
            # install the sign-file executable for future use.
            exeinto /usr/src/linux-${PV}-${KERNEL_EXTRAVERSION}/scripts
            doexe ${WORKDIR}/build/scripts/sign-file
        fi
    fi
}

pkg_postinst() {

    # TODO: Change to SANDBOX_WRITE=".." for Dracut writes
    export SANDBOX_ON=0

    # if USE=symlink...
    if use symlink; then
        # delete the existing symlink if one exists
        if [[ -h "${EROOT}"/usr/src/linux ]]; then
            rm "${EROOT}"/usr/src/linux
        fi
        # and now symlink the newly installed sources
        ewarn ""
        ewarn "WARNING... WARNING... WARNING"
        ewarn ""
        ewarn "/usr/src/linux symlink automatically set to linux-${PV}${KERNEL_EXTRAVERSION}"
        ewarn ""
        ln -sf "${EROOT}"/usr/src/linux-${PV}${KERNEL_EXTRAVERSION} "${EROOT}"/usr/src/linux
    fi

    # if there's a modules folder for these sources, generate modules.dep and map files
    if [[ -d ${EROOT}/lib/modules/${PV}${KERNEL_EXTRAVERSION} ]]; then
        depmod -a ${PV}${KERNEL_EXTRAVERSION}
    fi

    # NOTE: WIP and not well tested yet.
    #
    # Dracut will build an initramfs when USE=binary.
    #
    # The initramfs will be configurable via USE, i.e.
    # USE=zfs will pass '--zfs' to Dracut
    # USE=-systemd will pass '--omit dracut-systemd systemd systemd-networkd systemd-initrd' to exclude these (Dracut) modules from the initramfs.
    #
    # NOTE 2: this will create a fairly.... minimal, and modular initramfs. It has been tested with things with ZFS and LUKS, and 'works'.
    # Things like network support have not been tested (I am currently unsure how well this works with Gentoo Linux based systems),
    # and may end up requiring network-manager for decent support (this really needs further research).
    if use binary; then
        einfo ""
        einfo ">>> Dracut: building initramfs"
        dracut \
        --stdlog=1 \
        --force \
        --no-hostonly \
        --add "base dm fs-lib i18n kernel-modules rootfs-block shutdown terminfo udev-rules usrmount" \
        --omit "biosdevname bootchart busybox caps convertfs dash debug dmsquash-live dmsquash-live-ntfs fcoe fcoe-uefi fstab-sys gensplash ifcfg img-lib livenet mksh network network-manager qemu qemu-net rpmversion securityfs ssh-client stratis syslog url-lib" \
        $(usex btrfs "-a btrfs" "-o btrfs") \
        $(usex dmraid "-a dmraid" "-o dmraid") \
        $(usex hardened "-o resume" "-a resume") \
        $(usex iscsi "-a iscsi" "-o iscsi") \
        $(usex lvm "-a lvm" "-o lvm") \
        $(usex lvm "--lvmconf" "--nolvmconf") \
        $(usex luks "-a crypt" "-o crypt") \
        $(usex mdadm "--mdadmconf" "--nomdadmconf") \
        $(usex mdadm "-a mdraid" "-o mdraid") \
        $(usex microcode "--early-microcode" "--no-early-microcode") \
        $(usex multipath "-a multipath" "-o multipath") \
        $(usex nbd "-a nbd" "-o nbd") \
        $(usex nfs "-a nfs" "-o nfs") \
        $(usex plymouth "-a plymouth" "-o plymouth") \
        $(usex selinux "-a selinux" "-o selinux") \
        $(usex systemd "-a systemd -a systemd-initrd -a systemd-networkd" "-o systemd -o systemd-initrd -o systemd-networkd") \
        $(usex zfs "-a zfs" "-o zfs") \
        --kver ${PV}${KERNEL_EXTRAVERSION} \
        --kmoddir ${EROOT}/lib/modules/${PV}${KERNEL_EXTRAVERSION} \
        --fwdir ${EROOT}/lib/firmware \
        --kernel-image ${EROOT}/boot/vmlinuz-${PV}${KERNEL_EXTRAVERSION}
        einfo ""
        einfo ">>> Dracut: Finished building initramfs"
        ewarn ""
        ewarn "WARNING... WARNING... WARNING..."
        ewarn ""
        ewarn "Dracut initramfs has been generated!"
        ewarn ""
        ewarn "Required kernel arguments:"
        ewarn ""
        ewarn "    root=/dev/ROOT"
        ewarn ""
        ewarn "    Where ROOT is the device node for your root partition as the"
        ewarn "    one specified in /etc/fstab"
        ewarn ""
        ewarn "Additional kernel cmdline arguments that *may* be required to boot properly..."
        ewarn ""
        ewarn "If you use hibernation:"
        ewarn ""
        ewarn "    resume=/dev/SWAP"
        ewarn ""
        ewarn "    Where $SWAP is the swap device used by hibernate software of your choice."
        ewarn""
        ewarn "    Please consult "man 7 dracut.kernel" for additional kernel arguments."
    fi

    # warn about the issues with running a hardened kernel
    if use hardened; then
        ewarn ""
        ewarn "WARNING... WARNING... WARNING..."
        ewarn ""
        ewarn "Hardened patches have been applied to the kernel and KCONFIG options have been set."
        ewarn "These KCONFIG options and patches change kernel behavior."
        ewarn "Changes include:"
        ewarn "Increased entropy for Address Space Layout Randomization"
        ewarn "GCC plugins (if using GCC)"
        ewarn "Memory allocation"
        ewarn "... and more"
        ewarn ""
        ewarn "These changes will stop certain programs from functioning"
        ewarn "e.g. VirtualBox, Skype"
        ewarn "Full information available in $DOCUMENTATION"
        ewarn ""
    fi

    # if there are out-of-tree kernel modules detected, warn warn warn
    # TODO: tidy up below
    if use binary && [[ -e "${EROOT}"/var/lib/module-rebuild/moduledb ]]; then
        ewarn ""
        ewarn "WARNING... WARNING... WARNING..."
        ewarn ""
        ewarn "External kernel modules are not yet automatically built"
        ewarn "by USE=binary - emerge @modules-rebuild to do this"
        ewarn "and regenerate your initramfs if you are using ZFS root filesystem"
        ewarn ""
    fi

    if use binary; then
        if [[ -e /etc/boot.conf ]]; then
            ego boot update
        fi
    fi
}
