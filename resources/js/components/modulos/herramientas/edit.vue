<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Herramientas</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">Modificar registro</h3>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <Formulario
                                        :accion="'edit'"
                                        :herramienta="oHerramienta"
                                    ></Formulario>
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
import Formulario from "./Formulario.vue";
export default {
    props: ["id"],
    components: {
        Formulario,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            oHerramienta: {
                id: 0,
                codigo: "",
                codificacion: "",
                nombre: "",
                descripcion: "",
                clasificacion: "",
                cod_clasificacion: "",
                marca: "",
                modelo: "",
                serie: "",
                costo: "",
                unidad_medida: "",
                proveedor: "",
                dir: "",
                fono: "",
                correo: "",
                almacen: "",
                fabricante: "",
                terciarios: "",
                nombre_contacto: "",
                num_fono: "",
                correo_fabricante: "",
                dir_fabricante: "",
                num_identificacion: "",
                e_tecnicas: "",
                foto: "",
            },
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getHerramienta();
    },
    methods: {
        getHerramienta() {
            axios("/admin/herramientas/" + this.id).then((response) => {
                this.oHerramienta = response.data.herramienta;
            });
        },
    },
};
</script>

<style></style>
