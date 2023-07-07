<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>
                            Reportes - Informe Ordenes de Trabajo Correctivas
                        </h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="ml-auto mr-auto col-md-5">
                                    <form>
                                        <div class="row">
                                            <div class="form-group col-md-12">
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.filtro,
                                                    }"
                                                    >Seleccione*</label
                                                >
                                                <el-select
                                                    v-model="oReporte.filtro"
                                                    filterable
                                                    placeholder="Seleccione"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.filtro,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listFiltro"
                                                        :key="item.id"
                                                        :value="item.id"
                                                        :label="item.label"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.filtro"
                                                    v-text="errors.filtro[0]"
                                                ></span>
                                            </div>
                                            <div
                                                class="form-group col-md-12"
                                                v-if="
                                                    oReporte.filtro == 'equipo'
                                                "
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.equipo,
                                                    }"
                                                    >Seleccione Equipo*</label
                                                >
                                                <el-select
                                                    v-model="oReporte.equipo"
                                                    filterable
                                                    placeholder="Seleccione"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid':
                                                            errors.equipo,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listEquipos"
                                                        :key="item.id"
                                                        :value="item.id"
                                                        :label="item.nombre"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.equipo"
                                                    v-text="errors.equipo[0]"
                                                ></span>
                                            </div>
                                            <div
                                                class="form-group col-md-12"
                                                v-if="oReporte.filtro == 'ot'"
                                            >
                                                <label
                                                    :class="{
                                                        'text-danger':
                                                            errors.ot,
                                                    }"
                                                    >Seleccione OT*</label
                                                >
                                                <el-select
                                                    v-model="oReporte.ot"
                                                    filterable
                                                    placeholder="Seleccione"
                                                    class="d-block"
                                                    :class="{
                                                        'is-invalid': errors.ot,
                                                    }"
                                                >
                                                    <el-option
                                                        v-for="item in listOTs"
                                                        :key="item.id"
                                                        :value="item.id"
                                                        :label="item.id"
                                                    >
                                                    </el-option>
                                                </el-select>
                                                <span
                                                    class="error invalid-feedback"
                                                    v-if="errors.ot"
                                                    v-text="errors.ot[0]"
                                                ></span>
                                            </div>
                                        </div>
                                    </form>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <el-button
                                                type="primary"
                                                class="bg-primary w-full"
                                                :loading="enviando"
                                                @click="generaReporte()"
                                                >{{ textoBtn }}</el-button
                                            >
                                        </div>
                                        <div class="col-md-12">
                                            <el-button
                                                type="default"
                                                class="w-full mt-1"
                                                @click="limpiarFormulario()"
                                                >Reiniciar</el-button
                                            >
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            errors: [],
            oReporte: {
                filtro: "todos",
                equipo: "",
                anio: "",
                mes: "",
                tipo_mantenimiento: "",
            },
            aFechas: [],
            enviando: false,
            textoBtn: "Generar Reporte",
            listFiltro: [
                { id: "todos", label: "Todos" },
                { id: "equipo", label: "Equipo" },
                { id: "ot", label: "OT" },
            ],
            listEquipos: [],
            listOTs: [],
            errors: [],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getEquipos();
        this.getOTs();
    },
    methods: {
        getOTs() {
            axios.get("/admin/orden_trabajos").then((response) => {
                this.listOTs = response.data.orden_trabajos;
            });
        },
        getEquipos() {
            axios.get("/admin/equipos").then((response) => {
                this.listEquipos = response.data.equipos;
            });
        },
        limpiarFormulario() {
            this.oReporte.filtro = "todos";
        },
        generaReporte() {
            this.enviando = true;
            let config = {
                responseType: "blob",
            };
            axios
                .post(
                    "/admin/reportes/informe_ot_correctivas",
                    this.oReporte,
                    config
                )
                .then((res) => {
                    this.errors = [];
                    this.enviando = false;
                    let pdfBlob = new Blob([res.data], {
                        type: "application/pdf",
                    });
                    let urlReporte = URL.createObjectURL(pdfBlob);
                    window.open(urlReporte);
                })
                .catch(async (error) => {
                    let responseObj = await error.response.data.text();
                    responseObj = JSON.parse(responseObj);
                    console.log(error);
                    this.enviando = false;
                    if (error.response) {
                        if (error.response.status === 422) {
                            this.errors = responseObj.errors;
                        }
                        if (
                            error.response.status === 420 ||
                            error.response.status === 419 ||
                            error.response.status === 401
                        ) {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                html: responseObj.message,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                            window.location = "/";
                        }
                    }
                });
        },
        obtieneFechas() {
            this.oReporte.fecha_ini = this.aFechas[0];
            this.oReporte.fecha_fin = this.aFechas[1];
        },
    },
};
</script>

<style></style>
