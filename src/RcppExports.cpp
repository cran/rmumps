// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include "../inst/include/rmumps.h"
#include <Rcpp.h>
#include <string>
#include <set>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// get_cnst
int get_cnst(std::string s);
RcppExport SEXP _rmumps_get_cnst(SEXP sSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type s(sSEXP);
    rcpp_result_gen = Rcpp::wrap(get_cnst(s));
    return rcpp_result_gen;
END_RCPP
}
// Rmumps__solveptr
void Rmumps__solveptr(XPtr<Rmumps> pobj, XPtr<double> pb, int lrhs, int nrhs);
static SEXP _rmumps_Rmumps__solveptr_try(SEXP pobjSEXP, SEXP pbSEXP, SEXP lrhsSEXP, SEXP nrhsSEXP) {
BEGIN_RCPP
    Rcpp::traits::input_parameter< XPtr<Rmumps> >::type pobj(pobjSEXP);
    Rcpp::traits::input_parameter< XPtr<double> >::type pb(pbSEXP);
    Rcpp::traits::input_parameter< int >::type lrhs(lrhsSEXP);
    Rcpp::traits::input_parameter< int >::type nrhs(nrhsSEXP);
    Rmumps__solveptr(pobj, pb, lrhs, nrhs);
    return R_NilValue;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _rmumps_Rmumps__solveptr(SEXP pobjSEXP, SEXP pbSEXP, SEXP lrhsSEXP, SEXP nrhsSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_rmumps_Rmumps__solveptr_try(pobjSEXP, pbSEXP, lrhsSEXP, nrhsSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// Rmumps__ptr_ijv
XPtr<Rmumps> Rmumps__ptr_ijv(XPtr<int> pi, XPtr<int> pj, XPtr<double> pa, int n, int nz, int sym);
static SEXP _rmumps_Rmumps__ptr_ijv_try(SEXP piSEXP, SEXP pjSEXP, SEXP paSEXP, SEXP nSEXP, SEXP nzSEXP, SEXP symSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< XPtr<int> >::type pi(piSEXP);
    Rcpp::traits::input_parameter< XPtr<int> >::type pj(pjSEXP);
    Rcpp::traits::input_parameter< XPtr<double> >::type pa(paSEXP);
    Rcpp::traits::input_parameter< int >::type n(nSEXP);
    Rcpp::traits::input_parameter< int >::type nz(nzSEXP);
    Rcpp::traits::input_parameter< int >::type sym(symSEXP);
    rcpp_result_gen = Rcpp::wrap(Rmumps__ptr_ijv(pi, pj, pa, n, nz, sym));
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _rmumps_Rmumps__ptr_ijv(SEXP piSEXP, SEXP pjSEXP, SEXP paSEXP, SEXP nSEXP, SEXP nzSEXP, SEXP symSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_rmumps_Rmumps__ptr_ijv_try(piSEXP, pjSEXP, paSEXP, nSEXP, nzSEXP, symSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// Rmumps__del_ptr
void Rmumps__del_ptr(XPtr<Rmumps> pm);
static SEXP _rmumps_Rmumps__del_ptr_try(SEXP pmSEXP) {
BEGIN_RCPP
    Rcpp::traits::input_parameter< XPtr<Rmumps> >::type pm(pmSEXP);
    Rmumps__del_ptr(pm);
    return R_NilValue;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _rmumps_Rmumps__del_ptr(SEXP pmSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_rmumps_Rmumps__del_ptr_try(pmSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// Rmumps__triplet
List Rmumps__triplet(XPtr<Rmumps> pm);
static SEXP _rmumps_Rmumps__triplet_try(SEXP pmSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< XPtr<Rmumps> >::type pm(pmSEXP);
    rcpp_result_gen = Rcpp::wrap(Rmumps__triplet(pm));
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _rmumps_Rmumps__triplet(SEXP pmSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_rmumps_Rmumps__triplet_try(pmSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// Rmumps__set_mat_ptr
void Rmumps__set_mat_ptr(XPtr<Rmumps> pm, XPtr<double> pa);
static SEXP _rmumps_Rmumps__set_mat_ptr_try(SEXP pmSEXP, SEXP paSEXP) {
BEGIN_RCPP
    Rcpp::traits::input_parameter< XPtr<Rmumps> >::type pm(pmSEXP);
    Rcpp::traits::input_parameter< XPtr<double> >::type pa(paSEXP);
    Rmumps__set_mat_ptr(pm, pa);
    return R_NilValue;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _rmumps_Rmumps__set_mat_ptr(SEXP pmSEXP, SEXP paSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_rmumps_Rmumps__set_mat_ptr_try(pmSEXP, paSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// Rmumps__set_permutation
void Rmumps__set_permutation(XPtr<Rmumps> pm, int permutation);
static SEXP _rmumps_Rmumps__set_permutation_try(SEXP pmSEXP, SEXP permutationSEXP) {
BEGIN_RCPP
    Rcpp::traits::input_parameter< XPtr<Rmumps> >::type pm(pmSEXP);
    Rcpp::traits::input_parameter< int >::type permutation(permutationSEXP);
    Rmumps__set_permutation(pm, permutation);
    return R_NilValue;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _rmumps_Rmumps__set_permutation(SEXP pmSEXP, SEXP permutationSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_rmumps_Rmumps__set_permutation_try(pmSEXP, permutationSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}
// Rmumps__get_permutation
int Rmumps__get_permutation(XPtr<Rmumps> pm);
static SEXP _rmumps_Rmumps__get_permutation_try(SEXP pmSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::traits::input_parameter< XPtr<Rmumps> >::type pm(pmSEXP);
    rcpp_result_gen = Rcpp::wrap(Rmumps__get_permutation(pm));
    return rcpp_result_gen;
END_RCPP_RETURN_ERROR
}
RcppExport SEXP _rmumps_Rmumps__get_permutation(SEXP pmSEXP) {
    SEXP rcpp_result_gen;
    {
        Rcpp::RNGScope rcpp_rngScope_gen;
        rcpp_result_gen = PROTECT(_rmumps_Rmumps__get_permutation_try(pmSEXP));
    }
    Rboolean rcpp_isInterrupt_gen = Rf_inherits(rcpp_result_gen, "interrupted-error");
    if (rcpp_isInterrupt_gen) {
        UNPROTECT(1);
        Rf_onintr();
    }
    bool rcpp_isLongjump_gen = Rcpp::internal::isLongjumpSentinel(rcpp_result_gen);
    if (rcpp_isLongjump_gen) {
        Rcpp::internal::resumeJump(rcpp_result_gen);
    }
    Rboolean rcpp_isError_gen = Rf_inherits(rcpp_result_gen, "try-error");
    if (rcpp_isError_gen) {
        SEXP rcpp_msgSEXP_gen = Rf_asChar(rcpp_result_gen);
        UNPROTECT(1);
        Rf_error(CHAR(rcpp_msgSEXP_gen));
    }
    UNPROTECT(1);
    return rcpp_result_gen;
}

// validate (ensure exported C++ functions exist before calling them)
static int _rmumps_RcppExport_validate(const char* sig) { 
    static std::set<std::string> signatures;
    if (signatures.empty()) {
        signatures.insert("void(*Rmumps__solveptr)(XPtr<Rmumps>,XPtr<double>,int,int)");
        signatures.insert("XPtr<Rmumps>(*Rmumps__ptr_ijv)(XPtr<int>,XPtr<int>,XPtr<double>,int,int,int)");
        signatures.insert("void(*Rmumps__del_ptr)(XPtr<Rmumps>)");
        signatures.insert("List(*Rmumps__triplet)(XPtr<Rmumps>)");
        signatures.insert("void(*Rmumps__set_mat_ptr)(XPtr<Rmumps>,XPtr<double>)");
        signatures.insert("void(*Rmumps__set_permutation)(XPtr<Rmumps>,int)");
        signatures.insert("int(*Rmumps__get_permutation)(XPtr<Rmumps>)");
    }
    return signatures.find(sig) != signatures.end();
}

// registerCCallable (register entry points for exported C++ functions)
RcppExport SEXP _rmumps_RcppExport_registerCCallable() { 
    R_RegisterCCallable("rmumps", "_rmumps_Rmumps__solveptr", (DL_FUNC)_rmumps_Rmumps__solveptr_try);
    R_RegisterCCallable("rmumps", "_rmumps_Rmumps__ptr_ijv", (DL_FUNC)_rmumps_Rmumps__ptr_ijv_try);
    R_RegisterCCallable("rmumps", "_rmumps_Rmumps__del_ptr", (DL_FUNC)_rmumps_Rmumps__del_ptr_try);
    R_RegisterCCallable("rmumps", "_rmumps_Rmumps__triplet", (DL_FUNC)_rmumps_Rmumps__triplet_try);
    R_RegisterCCallable("rmumps", "_rmumps_Rmumps__set_mat_ptr", (DL_FUNC)_rmumps_Rmumps__set_mat_ptr_try);
    R_RegisterCCallable("rmumps", "_rmumps_Rmumps__set_permutation", (DL_FUNC)_rmumps_Rmumps__set_permutation_try);
    R_RegisterCCallable("rmumps", "_rmumps_Rmumps__get_permutation", (DL_FUNC)_rmumps_Rmumps__get_permutation_try);
    R_RegisterCCallable("rmumps", "_rmumps_RcppExport_validate", (DL_FUNC)_rmumps_RcppExport_validate);
    return R_NilValue;
}
