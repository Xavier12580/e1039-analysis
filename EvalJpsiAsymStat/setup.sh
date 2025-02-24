DIR_TOP=$(dirname $(readlink -f $BASH_SOURCE))
DIR_BUILD=$DIR_TOP/build
DIR_INST=$DIR_TOP/inst

#source /e906/app/software/osg/software/e1039/this-e1039.sh
source /e906/app/software/osg/users/kenichi/e1039/core-20220104/this-e1039.sh
#source /e906/app/software/osg/users/$USER/e1039/core/this-e1039.sh
export   LD_LIBRARY_PATH=$DIR_INST/lib:$LD_LIBRARY_PATH
export ROOT_INCLUDE_PATH=$DIR_TOP/inst/include:$ROOT_INCLUDE_PATH

function cmake-this {
    if [ -e $DIR_BUILD ] ; then
	echo "Clean up the build directory..."
	\rm -rf $DIR_BUILD
    fi
    if [ -e $DIR_INST ] ; then
	echo "Clean up the install directory..."
	\rm -rf $DIR_INST
    fi
    mkdir -p $DIR_BUILD
    echo "Run cmake..."
    ( cd $DIR_BUILD && cmake -DCMAKE_INSTALL_PREFIX=$DIR_INST $DIR_TOP/src )
    local RET=$?
    if [ $RET -eq 0 ] ; then
	echo "OK.  Run 'make-this' at any time/directory."
    else
	echo "NG.  Need a fix."
    fi
    return $RET
}

function make-this {
    if [ ! -e $DIR_BUILD/Makefile ] ; then
	echo "The build directory is not ready.  Complete 'cmake-this' first."
	return 1
    fi
    ( cd $DIR_BUILD && make install )
    return $?
}
