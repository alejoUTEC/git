#!/bin/sh

test_description='multi-pack-indexes'
. ./test-lib.sh

midx_read_expect() {
	cat >expect <<- EOF
	header: 4d494458 1 0 0
	object_dir: .
	EOF
	test-tool read-midx . >actual &&
	test_cmp expect actual
}

test_expect_success 'write midx with no packs' '
	git multi-pack-index --object-dir=. write &&
	test_path_is_file pack/multi-pack-index &&
	midx_read_expect
'

test_done
