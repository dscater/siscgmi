<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Modelo Deterministico - Cáculo de Parametros</h1>
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
                                    'modelo_deterministicos.modelo_repuestos'
                                )
                            "
                            :to="{
                                name: 'modelo_deterministicos.modelo_repuestos',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list-alt"></i>
                            Modelo Deterministico de Repuestos
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-4">
                                        <label>Costo por Ordenar</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.co"
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Costo de Adquisición</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.cv"
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Costo de Mantenimiento</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.cm"
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Lead Time</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.l"
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Unidad de Tiempo</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.u"
                                        />
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Demanda Pronosticada</label>
                                        <input
                                            type="number"
                                            class="form-control"
                                            v-model="datos.d"
                                        />
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
                co: "",
                cv: "",
                cm: "",
                l: "",
                u: 12,
                d: "",
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {},
};
</script>

<style></style>
