<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Modelo Deterministico de Repuestos</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row pl-1 pr-1">
                    <div class="col-md-4 pl-0 pr-0">
                        <router-link
                            v-if="
                                permisos.includes(
                                    'modelo_deterministicos.index'
                                )
                            "
                            :to="{
                                name: 'modelo_deterministicos.index',
                            }"
                            class="btn btn-info btn-flat btn-block border-white"
                        >
                            <i class="fa fa-arrow-left"></i>
                            Volver a Modelo Deterministico
                        </router-link>
                    </div>
                    <div class="col-md-4 pl-0 pr-0">
                        <router-link
                            v-if="
                                permisos.includes(
                                    'modelo_deterministicos.parametros'
                                )
                            "
                            :to="{
                                name: 'modelo_deterministicos.parametros',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list-alt"></i>
                            Cálculo de Parámetros
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-3">
                                        <label>Año Inicio</label>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            v-model="datos.anio_ini"
                                        >
                                            <option value="">
                                                Seleccione...
                                            </option>
                                            <option
                                                v-for="(
                                                    item, index
                                                ) in listAnios"
                                                :value="item"
                                                :key="index"
                                            >
                                                {{ item }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label>Inicio Trimestre</label>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            v-model="datos.tirmestre_ini"
                                        >
                                            <option value="">
                                                Seleccione...
                                            </option>
                                            <option
                                                v-for="(
                                                    item, index
                                                ) in listTrimestres"
                                                :value="item"
                                                :key="index"
                                            >
                                                {{ item }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label>Año Fin</label>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            v-model="datos.anio_fin"
                                        >
                                            <option value="">
                                                Seleccione...
                                            </option>
                                            <option
                                                v-for="(
                                                    item, index
                                                ) in listAnios"
                                                :value="item"
                                                :key="index"
                                            >
                                                {{ item }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <label>Fin Trimestre</label>
                                        <select
                                            name=""
                                            id=""
                                            class="form-control"
                                            v-model="datos.trimestre_fin"
                                        >
                                            <option value="">
                                                Seleccione...
                                            </option>
                                            <option
                                                v-for="(
                                                    item, index
                                                ) in listTrimestres"
                                                :value="item"
                                                :key="index"
                                            >
                                                {{ item }}
                                            </option>
                                        </select>
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
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            datos: {
                anio_ini: "",
                tirmestre_ini: "",
                anio_fin: "",
                trimestre_fin: "",
            },
            listAnios: [this.$moment().format("YYYY")],
            listTrimestres: [1, 2, 3, 4],
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getAnios();
    },
    methods: {
        getAnios() {
            axios
                .get("/admin/orden_trabajos/getAniosOt")
                .then((response) => {
                    this.listAnios = response.data;
                })
                .catch((error) => {
                    this.listAnios = [$moment().format("YYYY")];
                });
        },
    },
};
</script>

<style></style>
