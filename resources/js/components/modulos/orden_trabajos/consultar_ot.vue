<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Ordenes de trabajo - Consultar OT's</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row pl-1 pr-1">
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            :to="{
                                name: 'orden_trabajos.index',
                            }"
                            v-if="permisos.includes('orden_trabajos.index')"
                            class="btn btn-info btn-flat btn-block border-white"
                        >
                            <i class="fa fa-arrow-left"></i>
                            Ordenes de trabajo
                        </router-link>
                    </div>
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('orden_trabajos.index')"
                            :to="{ name: 'orden_trabajos.programacion' }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list-alt"></i>
                            Programación
                        </router-link>
                    </div>
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('orden_generadas.index')"
                            :to="{
                                name: 'orden_trabajos.generar_ots',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list"></i>
                            Generar OT
                        </router-link>
                    </div>
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('pedido_repuestos.index')"
                            :to="{
                                name: 'orden_trabajos.pedido_repuestos',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fas fa-tasks"></i>
                            Pedido de Repuestos
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-3">
                                        <button
                                            type="button"
                                            class="btn btn-primary btn-block"
                                            @click="muestraCanva"
                                        >
                                            Vista Canva
                                        </button>
                                    </div>
                                    <div class="col-md-3">
                                        <button
                                            type="button"
                                            class="btn btn-primary btn-block"
                                            @click="muestraTimeline"
                                        >
                                            Vista timeline
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <VCanva
                                    :mostrando="muestra_canva"
                                    v-if="muestra_canva"
                                ></VCanva>
                                <VTimeline
                                    :mostrando="muestra_timeline"
                                    v-if="muestra_timeline"
                                ></VTimeline>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import VCanva from "./parcial/VCanva.vue";
import VTimeline from "./parcial/VTimeline.vue";
export default {
    components: {
        VCanva,
        VTimeline,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_canva: false,
            muestra_timeline: false,
        };
    },
    mounted() {
        this.loadingWindow.close();
    },
    methods: {
        muestraCanva() {
            this.muestra_canva = true;
            console.log("SAA");
            this.muestra_timeline = false;
        },
        muestraTimeline() {
            this.muestra_canva = false;
            this.muestra_timeline = true;
        },
    },
};
</script>

<style></style>
